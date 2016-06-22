class AddHotToCountries < ActiveRecord::Migration
  def change
  	add_column :countries, :hot, :boolean
  end
end
