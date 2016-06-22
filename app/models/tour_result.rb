class TourResult < ActiveRecord::Base
  belongs_to :hotel
  # belongs_to :tour_operator

  def date_end
  	depart_date + nights.days
  end
end
