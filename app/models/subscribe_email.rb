class SubscribeEmail < ActiveRecord::Base
  validates :email, uniqueness: true
end
