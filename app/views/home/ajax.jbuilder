json.resorts @resorts do |res|
	json.type "resort"
	json.id res.id
	json.name res.name
	json.country res.country.name if res.country
end


json.hotels @hotels do |res|
	json.image res.sletat_image_universal_urls.first if res.sletat_image_universal_urls.present?
	json.type "hotel"
	json.id res.id
	json.name res.name
	json.country res.resort.country.name if (res && res.resort)
end


json.countries @countries do |res|
	json.flag res.flag_link
	json.type "country"
	json.id res.id
	json.name res.name
	json.country res.name if res
end



