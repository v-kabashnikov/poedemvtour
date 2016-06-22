class BeachesResort < ActiveRecord::Base
  belongs_to :beach
  belongs_to :resort
end
