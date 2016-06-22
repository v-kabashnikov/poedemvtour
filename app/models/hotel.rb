class Hotel < ActiveRecord::Base
  include Sletat
  belongs_to :resort
  belongs_to :star
  has_many :flights, dependent: :destroy
  has_many :oil_taxes, dependent: :destroy
  has_many :search_results, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tour_results, dependent: :destroy
  has_and_belongs_to_many :facilities, uniq: true

  def position_info
    arr = []
    arr << resort.country.name if resort
    arr << resort.name if resort
    arr << "#{airport_distance.to_i} км от аэропорта" if airport_distance
    arr.join(', ')
  end

  def stars_count
    star.name.to_i if star
  end

  def nearby_hotels
    Hotel.where(resort_id: resort_id).order('random()').limit(9)
  end

  def update_info(info_res)
    sletat_photo_url = info_res[:image_urls][:string].kind_of?(Array) ? info_res[:image_urls][:string].try(:first) : info_res[:image_urls][:string]
    sletat_photo_url ||= "http://hotels.sletat.ru/i/f/#{sletat_id}_0.jpg"
    resp = open(URI(sletat_photo_url))
    if resp.meta['iis-httpstatuscode'] == '404'
      sletat_photo_url = nil
      # puts "hotel #{id}[#{sletat_id}] no photo :("
    end
    # binding.pry
    return if (info_res[:name] =~ /Экскурс/)
      update(
        name: info_res[:name],
        sletat_photo_url: sletat_photo_url,
        hotel_rate: info_res[:hotel_rate],
        resort_id: Resort.find_by(sletat_id: info_res[:resort_id].to_i).try(:id),
        airport_distance: info_res[:airport_distance],
        old_cyrillic_name: info_res[:old_cyrillic_name],
        old_latin_name: info_res[:old_latin_name],
        rating_meal: info_res[:rating_meal],
        rating_overall: info_res[:rating_overall],
        rating_place: info_res[:rating_place],
        rating_service: info_res[:rating_service],
        sletat_description: info_res[:description],
        city_center_distance: info_res[:city_center_distance],
        district: info_res[:district],
        latitude: info_res[:latitude],
        longitude: info_res[:longitude],
        star_id: Star.find_by(sletat_id: info_res[:star_id]).try(:id),
        sletat_image_urls: info_res[:image_urls][:string],
        building_date: (info_res[:building_date] if info_res[:building_date]),
        distance_to_lifts: (info_res[:distance_to_lifts].to_i if info_res[:distance_to_lifts]),
        rooms_count: info_res[:rooms_count],
        square: (info_res[:square].to_i if info_res[:square])
      )
  end

  def load_facilities
    if (facilities.count == 0)
      client = soap_client
      res = client.call :get_hotel_information, message: { hotel_id: sletat_id }
      info_res = res.body[:get_hotel_information_response][:get_hotel_information_result]
      hotel_info_facility_group = info_res[:hotel_facilities][:hotel_info_facility_group]
      hotel_facilities = []
      if hotel_info_facility_group
        hotel_info_facility_group = hotel_info_facility_group.kind_of?(Array) ? hotel_info_facility_group : [] << hotel_info_facility_group
        hotel_info_facility_group.each do |hifg|
          hfg = FacilityGroup.where(sletat_id: hifg[:id]).first_or_create(
            name: hifg[:name],
            sletat_id: hifg[:id]
          )
          facilities_arr = hifg[:facilities][:hotel_info_facility].kind_of?(Array) ? hifg[:facilities][:hotel_info_facility] : ([] << hifg[:facilities][:hotel_info_facility])
          hotel_facilities += facilities_arr.map{|f| f[:id]}
          facilities_arr.each do |facility|
            hfg.facilities.where(sletat_id: facility[:id]).first_or_create(
              name: facility[:name],
              sletat_id: facility[:id],
              hit: facility[:hit]
            )
          end
        end
      end
      unless hotel_facilities.empty?
        self.facilities = Facility.where(sletat_id: hotel_facilities)
      end
    end
  end

  def self.get_or_update(hid)
    # hotel = find_by(sletat_id: hid)
    hotel = where(sletat_id: hid).first_or_create
    client = hotel.soap_client
    if (!hotel.latitude || (Time.now - hotel.updated_at > 7.days))
      res = client.call :get_hotel_information, message: { hotel_id: hid }
      info_res = res.body[:get_hotel_information_response][:get_hotel_information_result]
      begin
        hotel.update_info(info_res)
      rescue => error
        puts("001 ERROR ===>> #{error.class} and #{error.message}")
      end
      begin
        hotel.load_reviews(client)
      rescue => error
        puts("002 ERROR ===>> #{error.class} and #{error.message}")
      end
    end
    hotel
  end

  def load_reviews(client)
    res_reviews = client.call :get_hotel_comments, message: { hotel_id: sletat_id }
    reviews_arr = res_reviews.body[:get_hotel_comments_response][:get_hotel_comments_result][:hotel_comment]
    if reviews_arr
      exist_reviews = reviews.where(sletat: true)
      reviews_arr = reviews_arr.kind_of?(Array) ? reviews_arr : ([] << reviews_arr)
      if exist_reviews.count < reviews_arr.count
        reviews_arr.each do |review|
          Review.where(comment: review[:positive].to_s + review[:negative].to_s, name: review[:user_name]).first_or_create(
            hotel_id: id,
            name: review[:user_name],
            comment: review[:positive].to_s + review[:negative].to_s,
            date: Hotel.parse_date_ru(review[:create_date_formatted]),
            rate: review[:rate],
            sletat: true
          )
        end
      end
    end
  end

  def self.parse_date_ru date
    monthes = {
      "января" => "01",
      "февраля" => "02",
      "марта" => "03",
      "апреля" => "04",
      "мая" => "05",
      "июня" => "06",
      "июля" => "07",
      "августа" => "08",
      "сентября" => "09",
      "октября" => "10",
      "ноября" => "11",
      "декабря" => "12"
    }
    pattern = /[а-я]+/
    if date
      a = date.gsub(pattern, monthes[date[pattern]].to_s)
      Date.strptime(a, '%d %m %Y')
    end
  end

  def sletat_image_universal_urls
    return [] if sletat_image_urls.blank?
    sletat_image_urls.each_with_object([]) { |url, arr| arr << url.gsub('http:', '') }
  end

  rails_admin do
    edit do
      include_all_fields

      exclude_fields :flights, :oil_taxes, :search_results, :tour_results
    end
  end
end
