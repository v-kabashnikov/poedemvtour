class DepartCity < ActiveRecord::Base
  extend Sletat
  belongs_to :country

  def self.sync
    data = get_res_data('GetDepartCities')
    if data
      data.each do |city|
        DepartCity.where(name: city['Name']).first_or_create do |c|
          c.sletat_id = city['Id']
          c.display = true
          c.country_id = Country.find_by(sletat_id: city['CountryId']).id
        end
      end
    end
  end
end
