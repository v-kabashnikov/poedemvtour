class MailContentParser
  attr_reader :params

  def initialize(email_template, options = {})
  	@email_template = email_template
  	@params = options.fetch(:params, {})
  end

  def call
    content = @email_template.content
    hotel = Hotel.where(id: params[:id]).first
    tour = hotel.tour_results.order(:id).find(params[:tour_id]) if hotel.present?
    date = Time.now

    content.gsub!('{TouristName}', params[:name]) if params[:name].present?
    content.gsub!('{TouristSurName}', params[:surname]) if params[:surname].present?
    content.gsub!('{TouristEMail}', params[:email]) if params[:email].present?
    content.gsub!('{TouristPhone}', params[:phone]) if params[:phone].present?
    content.gsub!('{TourOperatorName}', tour.tour_operator) if tour.present?
    content.gsub!('{HotelRang}', hotel.stars_count.to_s) if hotel.present?
    content.gsub!('{StartDate}', tour.depart_date.strftime('%d.%m.%Y')) if tour.present?
    content.gsub!('{EndDate}', tour.date_end.strftime('%d.%m.%Y')) if tour.present?
    content.gsub!('{TotalPrice}', tour.price.to_s) if tour.present?
    content.gsub!('{CurrentDate}', date.strftime('%d.%m.%Y'))
    content.gsub!('{CurrentTime}', date.strftime('%H:%M'))
    content.gsub!('{PaxCount}', (tour.adults_number.to_i + tour.children_number.to_i).to_s) if tour.present?
    content.gsub!('{ZakazID}', tour.id.to_s) if tour.present?
    content.gsub!('{FromCity}', tour.depart_city) if tour.present?
    content.gsub!('{ToCountryName}', hotel.resort.country.name) if hotel.present?
    content.gsub!('{ToResortName}', hotel.resort.name) if hotel.present?
    content.gsub!('{ToHotelName}', hotel.name) if hotel.present?
    content.gsub!('{NightsCount}', tour.nights.to_s) if tour.present?
    content.gsub!('{RoomType}', tour.room_type) if tour.present?
    content.gsub!('{MealType}', tour.meal) if tour.present?

    content
  end
end
