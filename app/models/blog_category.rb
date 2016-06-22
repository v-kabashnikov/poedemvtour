class BlogCategory < ActiveRecord::Base
  has_many :blogs
end
