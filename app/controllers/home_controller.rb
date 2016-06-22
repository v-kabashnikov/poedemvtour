require 'benchmark'
require 'open-uri'
require 'sletat'
class HomeController < ApplicationController
  before_action :captcha_params, only: [:hotel, :feedback]
  include SimpleCaptcha::ControllerHelpers
  layout 'static', except: 'index'
  # layout 'home', only: :index
  include Sletat

  def index
    @cities = DepartCity.all
    @countries = Country.where(:hot => true)
  end

  def thanks
    @hotel = Hotel.find(params[:id])
  end

  def buytour
    @search_request_id = params[:search_request_id]
    @offer_id = params[:offer_id]
    @source_id = params[:source_id]
    @hotel = Hotel.find(params[:id])
    parameters = { sourceId: @source_id, offerId: @offer_id, currencyAlias: "RUB", searchRequestId: @search_request_id, user: params[:surname], email: params[:email], phone: params[:phone], countryName: @hotel.resort.country, cityFromName: params[:depart_city]}
    get_res_data 'SaveTourOrder', false, parameters
    tour_request = TourRequest.create(
      surname: params[:surname],
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      passnum: params[:passnum],
      issued: params[:issued],
      issue_date: params[:issue_date],
      valid_until: params[:valid_until],
      hotel_id: params[:id],
      tour_id: params[:tour_id],
      guest: false
      )
    if !params[:additional_number].empty?
      params[:additional_number].to_i.times do |i|
        TourRequest.create(
          surname: params["surname#{i+1}"],
          name: params["name#{i+1}"],
          email: params["email#{i+1}"],
          phone: params["phone#{i+1}"],
          passnum: params["passnum#{i+1}"],
          issued: params["issued#{i+1}"],
          issue_date: params["issue_date#{i+1}"],
          valid_until: params["valid_until#{i+1}"],
          hotel_id: params[:id],
          tour_id: params[:tour_id],
          guest: true
        )
      end
    end
    UserMailer.buy_notification(params[:email], params: params).deliver
    UserMailer.buy_notification_manager('office_m@poedemvtour.ru', params: params).deliver
    redirect_to "/thanks/#{params[:id]}"
  end

  def tour
    @hotel = Hotel.find(params[:id])
    @tour = @hotel.tour_results.find(params[:tour])
    countryId = @hotel.resort.country.sletat_id
    requestId = @tour.request_id
    parameters = { sourceId: @tour.source_id, offerId: @tour.offer_id, currencyAlias: "RUB", requestId: requestId, countryId: countryId }
    flight_data = get_res_data 'ActualizePrice', true, parameters
    flight_data["oilTaxes"].each do |f|
      OilTax.find_or_create_by(
        start_date: f[5],
        finish_date: f[6],
        amount: f[0],
        currency: f[1],
        hotel_id: @hotel.id
      )
      Flight.find_or_create_by(
        date: flight_data["data"][4],
        hotel_id: @hotel.id,
        operator: f[2],
        arrival_airport: f[8],
        flight_number: f[9]
      )
    end
    @oil_taxes = OilTax.where(hotel_id: @hotel.id)
    @flights = Flight.where(hotel_id: @hotel.id)
    @link = "/tournext/#{@hotel.id}?tour=#{@tour.id}"
  end

  def tournext
    @hotel = Hotel.find(params[:id])
    @tour = @hotel.tour_results.find(params[:tour])
    @link = "/buytour/#{@hotel.id}"
  end

  def feedback
    if simple_captcha_valid?
      params[:family] ? people = 3 : people  = 1
      params[:date].empty? ? date = DateTime.now : date = Date.parse(params[:date])
      rate = ((params[:meal].to_i+params[:service].to_i)/2)
      @review = Review.create(name: params[:name], date: date, comment: params[:opinion], people_number: people ,rate: rate, hotel_id: params[:hotel_id], moderated: false)
      if params[:review]
        params[:review].each do |image|
          @revimg = Revimg.new
          @revimg.image = image[1]
          @revimg.review_id = @review.id
          @revimg.save
        end
      end
      @hotel = Hotel.find(params[:hotel_id])
      UserMailer.send_signup_email("https://poedemvtour.ru/admin/review/#{@review.id}/edit").deliver
    end
     redirect_to :back
  end


  def ajax
    if params[:p].length >= 3
    @resorts = Resort.where("lower(name) LIKE lower(?)", "%#{params[:p]}%")
    @hotels = Hotel.where("lower(name) LIKE lower(?)", "%#{params[:p]}%")
    @countries = Country.where("lower(name) LIKE lower(?)", "%#{params[:p]}%")
    end
    # render :json => @search_output
    # render nothing: true
  end

  def hotel
    @review = Review.new
    @revimg = Revimg.create(review_id: @review.id)
    @depart_city = params[:depart_city]
    @city_id = params[:city_id]
    @place_id = params[:place_id]
    @place_type = params[:place_type]
    @nights_min = params[:nights_min]
    @nights_max = params[:nights_max]
    @date_min = params[:date_min]
    @date_max = params[:date_max]
    @children = params[:children]
    @arrive_place = params[:arrive_place]
    @price = params["roundtour-price"]
    @adults = params[:adult]
    @cities = DepartCity.all
    @hotel = Hotel.find(params[:id])
    weather_url = nil
    if @hotel.latitude && @hotel.longitude
      weather_url = "http://api.openweathermap.org/data/2.5/weather?lat=#{@hotel.latitude}&lon=#{@hotel.longitude}&units=metric&lang=ru&appid=5613a0135fbd6cc6488bdd20c8aa5572"
    elsif @hotel.resort
      weather_url = URI.escape("http://api.openweathermap.org/data/2.5/weather?q=#{@hotel.resort.name},#{@hotel.resort.country.name}&units=metric&lang=ru&appid=5613a0135fbd6cc6488bdd20c8aa5572")
    end
    if weather_url
      json = open(weather_url).read
      res = JSON.parse(json)
      @weather = {
        desc: (res['weather'].first['description'] if res['weather']),
        temp: (res['main']['temp'].abs.to_i if res['main']),
        sign: (res['main']['temp'] > 0 ? '+' : '-' if res['main']),
        icon: "weather/#{res['weather'].first['icon'][/[\d]+/]}.png"
      }
    end

    @request = LoadStatus.find_by(request_id: params['requestId'])

    if @request.blank?
      data = {}

      data[:depart_city] = 'Москва'
      data[:city_id] = 832
      data[:place_id] = @hotel.id
      data[:place_type] = 'hotel'
      data[:date_min] = date_filter
      data[:nights_min] = 7
      data[:nights_max] = 10
      data[:adult] = 2

      @request = start_search(data)
    end

    if @request.status == 1
      @tours = @hotel.tour_results.where(request_id: @request.request_id).order(price: :asc).limit(5)
      @total_tours = @hotel.tour_results.where(request_id: @request.request_id).count
    end

    @depart_cities = DepartCity.all
    @hotel.load_facilities
    @facilities = @hotel.facilities.order(:facility_group_id).chunk(&:facility_group_id)
  end

  def check_tours
    requestId = params[:requestId]
    @hotel = Hotel.find(params[:id])
    if LoadStatus.find_by(request_id: requestId)
      if LoadStatus.find_by(request_id: requestId).status == 1
        @status = 'finished'
        @tours = @hotel.tour_results.where(request_id: params['requestId'].to_i).limit(5).order(price: :asc )
        @total_tours = @hotel.tour_results.where(request_id: params['requestId'].to_i).count
        @load_more = @total_tours > 5
      else
        @status = 'loading'
        render nothing: true
      end
    end
    # ls = LoadStatus.find_by(request_id: requestId)
    # binding.pry
    # @results = ls.results.select{|tour| tour[3] == @hotel.sletat_id}
    # @status = ls.status
  end

  def load_more_tours
    per_page = 5;
    @hotel = Hotel.find(params[:id])
    total_tours = @hotel.tour_results.where(request_id: params['requestId']).count
    offset = params[:page].to_i * per_page
    @loaded = total_tours <= offset + per_page
    @tours = @hotel.tour_results.where(request_id: params['requestId']).limit(per_page).order(price: :asc ).offset(offset)
  end

  def search


    # s_nights = params["s_nights"].split('-')
    # s_departFrom = Date.parse(params['s_departFrom'])
    # s_departTo = s_departFrom + 45.days
    # url_params = { cityFromId: params[:cityFromId], countryId: params[:countryId],
    #                s_adults: params[:s_adults], s_kids: params[:s_kids], s_nightsMin: s_nights[0], s_nightsMax: s_nights[1],
    #                s_priceMin: params[:s_priceMin], s_priceMax: params[:s_priceMax], s_departFrom: s_departFrom.strftime("%d/%m/%Y"),
    #                s_departTo: s_departTo.strftime("%d/%m/%Y"), s_hotelIsNotInStop: true, s_hasTickets: true,
    #                includeDescriptions: 1, updateResult: 0 }

    # data = get_res_data 'GetTours', true, url_params
    # requestId = data["requestId"]

    # url_params[:updateResult] = 1
    # url_params[:requestId] = requestId
    # url_params[:pageSize] = 3000

    # TourLoader.perform_async(requestId, url_params)
    @depart_city = params[:depart_city]
    @city_id = params[:city_id]
    @place_id = params[:place_id]
    @place_type = params[:place_type]
    @nights_min = params[:nights_min]
    @nights_max = params[:nights_max]
    @date_min = params[:date_min]
    @date_max = params[:date_max]
    @children = params[:children]
    @arrive_place = params[:arrive_place]
    @price = params["roundtour-price"]
    @adults = params[:adult]
    if @adults == "3"
      @people = "троих"
    elsif @adults == "2"
      @people = "двоих"
    elsif @adults == "4"
      @people = "четверых"
    end
    @request = start_search(params)
    @country = @request.country
    if params[:place_type] == 'hotel'
      redirect_to "/hotel/#{params[:place_id]}?requestId=#{@request.request_id}&depart_city=#{@depart_city}&city_id=#{@city_id}&place_id=#{@place_id}&place_type=#{@place_type}&nights_min=#{@nights_min}&nights_max=#{@nights_max}&children=#{@children}&arrive_place=#{@arrive_place}&adults=#{@adults}"
    end

    # @requestId = requestId
  end

  def search_hotel
    @request = start_search(params)
    redirect_to "#{hotel_path(params[:hotel_id])}?requestId=#{@request.request_id}"
  end

  #put to helper
  def is_true?(string)
    ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(string)
  end

  def check
    meal  = ["BB", "HB", "HB+", "FB", "FB+", "AL", "UAL"]
    stars = ["5*", "4*", "3*"]
    rs = ResAmount.first.amount
    requestId = params[:requestId]
    @results = SearchResult.where(request_id: params[:requestId]).where(meal: meal, min_price: 10000..15000000).joins(hotel: [:star]).where('stars.name' => stars).preload(hotel: [:reviews, :star, resort: [:country]]).order(min_price: :asc).limit(rs)
    #@results = SearchResult.where(request_id: params[:requestId]).preload(hotel: [:reviews, resort: [:country]]).order(min_price: :asc).limit(rs)
    @total = SearchResult.where(request_id: requestId).count
    if LoadStatus.find_by(request_id: requestId).status == 1
      @status = 'finished'
    else
      @status = 'loading'
    end
  end

  def load_more
    meal  = ["BB", "HB", "HB+", "FB", "FB+", "AL", "UAL"]
    stars = ["5*", "4*", "3*"]
    @total = SearchResult.where(request_id: params[:requestId]).count
    rs = ResAmount.first.amount
    @results = SearchResult.where(request_id: params[:requestId]).where(meal: meal, min_price: 10000..15000000).joins(hotel: [:star]).where('stars.name' => stars).preload(hotel: [:reviews, :star, resort: [:country]]).order(min_price: :asc).limit(rs).offset(params[:loaded])
    if LoadStatus.find_by(request_id: params[:requestId]).status == 1
      @status = 'finished'
    else
      @status = 'loading'
    end
    render 'check'
  end

  def filter
      requestId = params[:requestId]
      rs = ResAmount.first.amount

      if LoadStatus.find_by(request_id: requestId).status == 1
        @status = 'finished'
      else
        @status = 'loading'
      end
      p = params[:filter]

      meal  = []
      meal << "BB" if is_true?(p[:eat1])
      meal << "HB" << "HB+" if is_true?(p[:eat2])
      meal << "FB" << "FB+" if is_true?(p[:eat3])
      meal << "AL" << "UAL" if is_true?(p[:eat4])
      meal << "RO" if is_true?(params[:eat5])
      stars = []
      stars << "5*" if is_true?(p[:class1])
      stars << "4*" if is_true?(p[:class2])
      stars << "3*" if is_true?(p[:class3])
      @results = SearchResult.where(request_id: params[:requestId]).where(meal: meal, min_price: p[:priceMin]..p[:priceMax]).joins(hotel: [:star]).where('stars.name' => stars).preload(hotel: [:reviews, :star, resort: [:country]]).order(min_price: :asc)
      @total = @results.count
      render 'check'
  end

  private
  def captcha_params
    params.permit(:col, :id, :text, :captcha, :captcha_key)
  end
end
