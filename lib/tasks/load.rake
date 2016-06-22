require 'open-uri'

namespace :dict do
  task load: :environment do
    path, url = 'tmp/Dictionaries.xml', 'http://module.sletat.ru/Dictionaries.xml'
    load_file(path, url)
    doc = Nokogiri::XML(File.open(path))
    puts doc.xpath('dictionaries/facilities/facility')
    countries = doc.xpath('dictionaries/countries/country')
    countries.each_with_index do |country, i|
      Country.where(name: country['name']).first_or_create do |c|
        c.sletat_id = country['id']
        c.display = true
      end
      puts "country #{i+1}/#{countries.count}"
    end

    stars = doc.xpath('dictionaries/stars/star')
    stars.each_with_index do |star, i|
      Star.where(name: star['name']).first_or_create do |c|
        c.sletat_id = star['id']
      end
      puts "star #{i+1}/#{stars.count}"
    end

    meals = doc.xpath('dictionaries/meals/meal')
    meals.each_with_index do |meal, i|
      Meal.where(name: meal['name']).first_or_create do |c|
        c.sletat_id = meal['id']
      end
      puts "meal #{i+1}/#{meals.count}"
    end

    depart_cities = doc.xpath('dictionaries/departureCities/departureCity')
    depart_cities.each_with_index do |departure_city, i|
      DepartCity.where(name: departure_city['name']).first_or_create do |c|
        c.sletat_id = departure_city['id']
        c.country_id = Country.find_by(sletat_id: departure_city['countryId']).try(:id)
        c.display = true
      end
      puts "city #{i+1}/#{depart_cities.count}"
    end

    resorts = doc.xpath('dictionaries/resorts/resort')
    resorts.each_with_index do |resort, i|
      Resort.where(name: resort['name']).first_or_create do |c|
        c.sletat_id = resort['id']
        c.country_id = Country.find_by(sletat_id: resort['countryId']).try(:id)
        c.display = true
      end
      puts "resort #{i+1}/#{resorts.count}"
    end

     hotels = doc.xpath('dictionaries/hotels/hotel')
     hotels.each_with_index do |hotel, i|
       Hotel.where(name: hotel['name']).first_or_create do |c|
         c.sletat_id = hotel['id']
         c.resort_id = Resort.find_by(sletat_id: hotel['resortId']).try(:id)
         c.star_id = Star.find_by(sletat_id: hotel['starId']).try(:id)
       end
       puts "hotel #{i+1}/#{hotels.count}"
     end

  end

  def load_file(path, url)
    open(path, 'wb') do |file|
      file << open(url).read
    end
  end

end
