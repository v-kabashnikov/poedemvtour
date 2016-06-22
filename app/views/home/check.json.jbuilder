json.hotels @results do |res|
	json.image_url res.hotel.sletat_photo_url
	json.rating res.hotel.hotel_rate
	json.name res.hotel.name.upcase
	json.id res.hotel.id
	json.stars_count res.hotel.stars_count
	json.price number_with_delimiter(res.min_price, locale: :ru)
	json.meal res.meal
	json.depart_date res.depart_date
	json.nights res.nights
	if res.hotel.beach_line == "1"
		json.position_info "Первая береговая линия"
	elsif res.hotel.beach_line == "2"
		json.position_info "Вторая береговая линия"
	elsif res.hotel.beach_line == "3"
		json.position_info "Третья береговая линия"
	elsif res.hotel.beach_line == "0"
		json.position_info res.hotel.position_info
	else
		json.position_info res.hotel.position_info
	end
	json.reviews_count res.hotel.reviews.count
end

json.status @status
json.total @total
