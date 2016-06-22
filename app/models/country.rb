require 'open-uri'

class Country < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  extend Sletat
  belongs_to :country_category
  has_many :depart_cities
  has_many :resorts, dependent: :destroy
  has_many :hotels, through: :resorts

  has_many :photos, class_name: 'Image', as: :imageable
  accepts_nested_attributes_for :photos, allow_destroy: true

  has_attached_file :flag,
    styles: { thumb: "200x200", medium: "500x500>", big: "1000x1000>" }
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/

  has_attached_file :search_background,
    styles: { thumb: "200x200", medium: "500x500>", big: "1000x1000>" }
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/

   has_attached_file :banner,
    styles: { thumb: "200x200", medium: "500x500>", big: "1000x1000>" }
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/

  has_attached_file :header_img,
    styles: { thumb: "442x300#", medium: "500x500>", big: "1000x1000>" }
  validates_attachment_content_type :header_img, content_type: /\Aimage\/.*\Z/

  def self.sync
    data = get_res_data('GetCountries')
    if data
      data.each do |country|
        Country.where(name: country['Name']).first_or_create do |c|
          c.sletat_id = country['Id']
          c.alias = country['Alias'] if country['Alias'] != 'NIL'
          c.display = true
        end
      end
    end
  end

  rails_admin do
    edit do
      include_all_fields

      field :description, :ck_editor

      exclude_fields :hotels
    end
  end
end
