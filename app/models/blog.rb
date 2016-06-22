class Blog < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  belongs_to :blog_category
  has_attached_file :preview, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :preview, content_type: /\Aimage\/.*\Z/
end
