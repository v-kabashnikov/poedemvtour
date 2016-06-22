class LoadStatus < ActiveRecord::Base
	NIGHTS_RANGES = ['5-8', '9-14', '15-21']

	belongs_to :country
	belongs_to :depart_city
end
