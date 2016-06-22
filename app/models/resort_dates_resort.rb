class ResortDatesResort < ActiveRecord::Base
  belongs_to :resort_date
  belongs_to :resort
end
