class AddBannerToCountry < ActiveRecord::Migration
  def change
  	add_attachment :countries, :banner
  	add_column :countries, :ad_delay, :integer
  	add_column :countries, :youtube_link, :string
  end
end
