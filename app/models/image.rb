class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: {thumb: '442x300#', minim: '247x139#'}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    edit do
      field :image, :paperclip
    end
  end
end
