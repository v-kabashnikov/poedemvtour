class AddLinkToCountry < ActiveRecord::Migration
  def change
  	add_column :countries, :flag_link, :string
  end
end
