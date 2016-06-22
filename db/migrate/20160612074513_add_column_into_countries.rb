class AddColumnIntoCountries < ActiveRecord::Migration
  def change
  	add_column :countries, :youtube_link_country, :string
  end
end
