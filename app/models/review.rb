class Review < ActiveRecord::Base
  belongs_to :hotel
  has_many :revimgs
end
