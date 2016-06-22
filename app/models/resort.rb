class Resort < ActiveRecord::Base
  belongs_to :country
  has_many :hotels, dependent: :destroy

  has_one :photo, class_name: 'Image', as: :imageable
  accepts_nested_attributes_for :photo, allow_destroy: true

  has_and_belongs_to_many :beaches
  has_and_belongs_to_many :resort_dates

  def beach_names
    return if beaches.blank?

    beaches.map(&:name).join(', ')
  end

  def season_names
    resort_dates.order(:id).map { |resort_date| resort_date.site_name }.join(', ')
  end
end
