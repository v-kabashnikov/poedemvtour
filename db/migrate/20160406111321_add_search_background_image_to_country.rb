class AddSearchBackgroundImageToCountry < ActiveRecord::Migration
  def change
  	add_attachment :countries, :search_background
  end
end
