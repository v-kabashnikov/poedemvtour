require 'open-uri'
require 'rest-client'

module Sletat
  # also notice the call to 'freeze'
  SERVICE_URL = "https://module.sletat.ru/Main.svc/".freeze
  LOGIN = "pr@corona.travel"
  PASS = "1234567"

  SOAP_HEADER = {
    "AuthInfo" => {
      "@xmlns" => "urn:SletatRu:DataTypes:AuthData:v1",
      "Login"  => LOGIN,
      "Password"  => PASS
    }
  }

  def soap_client
    Savon.client(wsdl: "https://module.sletat.ru/XmlGate.svc?singleWSDL", soap_header: SOAP_HEADER)
  end

  def parse_date_ru date
    monthes = {
      "Янв" => "01",
      "Фев" => "02",
      "Мрт" => "03",
      "Апр" => "04",
      "Май" => "05",
      "Июн" => "06",
      "Июл" => "07",
      "Авг" => "08",
      "Сен" => "09",
      "Окт" => "10",
      "Нбр" => "11",
      "Дек" => "12"
    }
    pattern = /[А-я]+/
    if date
      a = date.gsub(pattern, monthes[date[pattern]].to_s)
      Date.strptime(a, '%d %m')
    end
  end

  def get_data method, auth, params
    url = SERVICE_URL + method + '?' + auth_str + '&' + params.to_query
    uri_schema = URI(url)
    puts uri_schema
    #RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
    res = RestClient.get(url)

    # json = open(uri_schema).read
    json = JSON.parse(res.body)
    puts url
    json
  end

  def get_res_data method, auth = false, params = nil
    data = get_data method, auth, params
    # puts data
    data["#{method}Result"]["Data"]
  end

  def start_search params
    if params[:s_nights]
      s_nightsMin = params[:s_nights].split('-')[0]
      s_nightsMax = params[:s_nights].split('-')[1]
    end
    # puts "==== 1111 ADULTS #{params[:s_adults]}"
    if params[:cityFromId]
      s_kids = params[:s_kids]
      cid = params[:cityFromId]
      hotel = Hotel.find(params[:hotel_id]) if params[:hotel_id]
      hotels = hotel.sletat_id if hotel
      countryId = params[:countryId] || (hotel.resort.country.sletat_id if hotel)
      s_departFrom = Date.parse(params['s_departFrom'])
      s_departTo = s_departFrom + 45.days
      s_adults = params[:s_adults]
    else
      s_kids = params[:children]
      cid = params[:city_id]
      s_adults = params[:adult]
      case params[:place_type]
        when 'hotel'
          hotel = Hotel.find(params[:place_id])
          hotels = hotel.sletat_id
          countryId = hotel.resort.country.sletat_id
        when 'resort'
          resort  = Resort.find(params[:place_id])
          cities = resort.sletat_id
          countryId = resort.country.sletat_id
        when 'country'
          countryId = Country.find(params[:place_id]).sletat_id
      end
      if params[:date_min]
        if params[:date_min].blank?
          s_departFrom = DateTime.now.to_date
        else
          s_departFrom = parse_date_ru(params[:date_min])
        end
      end

      s_departTo = params[:date_max].blank? ? s_departFrom :  parse_date_ru(params[:date_max])
      s_nightsMin = params[:nights_min].blank? ? "3" : params[:nights_min]
      s_nightsMax = params[:nights_max].blank? && params[:nights_min].blank? ? "3" : params[:nights_max]

      if params['roundtour-price']
        priceMax = params['roundtour-price'].split(';')[1]
        priceMin = params['roundtour-price'].split(';')[0]
      else
        priceMax = 1000000
        priceMin = 0
      end
    end

   # s_nights = params["s_nights"].split('-')
   # s_departFrom = Date.parse(params['s_departFrom'])
   # s_departTo = s_departFrom + 45.days
    meals = params[:meals].to_i > 0 ? params[:meals] : nil
    stars = [402,403,404]
   # hotel = Hotel.find(params[:hotel_id]) if params[:hotel_id]
   # hotels = hotel.sletat_id if hotel
   # countryId = params[:countryId] || (hotel.resort.country.sletat_id if hotel)
    url_params = { cityFromId: cid, countryId: countryId, cities: cities,
                   s_adults: s_adults, s_kids: s_kids, s_nightsMin: s_nightsMin, s_nightsMax: s_nightsMax,
                   s_priceMin: priceMin, s_priceMax: priceMax, s_departFrom: s_departFrom.strftime("%d/%m/%Y"),
                   s_departTo: s_departTo.strftime("%d/%m/%Y"), s_hotelIsNotInStop: true, s_ticketsIncluded: true,
                   includeDescriptions: 1, updateResult: 0, hotels: hotels, stars: stars, meals: meals}
    data = get_res_data 'GetTours', true, url_params
    requestId = data["requestId"]

    url_params[:updateResult] = 1
    url_params[:requestId] = requestId
    url_params[:pageSize] = 3000
    nights_string = "#{s_nightsMin}-#{s_nightsMax}"
    ls = LoadStatus.create(
      request_id: requestId,
      status: 0,
      country: Country.find_by_sletat_id(countryId),
      depart_city: DepartCity.find_by_sletat_id(cid),
      depart_from: s_departFrom,
      nights: nights_string,
      adults: s_adults.to_i,
      kids: s_kids.to_i
    )

    puts "start_search #{ls.id}"
    TourLoader.perform_async(requestId, url_params)
    ls
  end

  private
  def auth_str
    "login=#{LOGIN}&password=#{PASS}"
  end

end
