class Facility < ActiveRecord::Base
  belongs_to :facility_group
  has_and_belongs_to_many :hotels, uniq: true
end
