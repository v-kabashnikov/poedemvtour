class Weather
  def initialize(hotels)
  	@hotels = hotels
  	@conn = Faraday.new($config['default']['weather_api_url'])
  	@marine_url = "/premium/v1/marine.ashx?key=#{$config['default']['weather_api_key']}&format=json&lang=Ru"
  end

  def call
    result = {}

    weather_plus = ProjectSetting.find_by_slug('plus_weather_resort').val

  	@hotels.each do |hotel|
      next if result[hotel.resort_id].present? || hotel.latitude.blank? || hotel.longitude.blank?

  	  response = @conn.get("#{@marine_url}&q=#{hotel.latitude},#{hotel.longitude}")
      data = JSON.parse(response.body)
      next if data['data'].blank? || data['data']['weather'].blank?

      weather = data['data']['weather'].
        select { |item| item['date'].to_date == (Time.now + 1.day).to_date }.first

  	  result[hotel.resort_id] = {}

      result[hotel.resort_id]['mintempC'] = weather['mintempC'].to_i
      result[hotel.resort_id]['maxtempC'] = weather['maxtempC'].to_i
      result[hotel.resort_id]['waterTemp_C'] = weather['hourly'].last['waterTemp_C'].to_i + weather_plus.to_i
  	end

  	result
  rescue
    {}
  end
end
