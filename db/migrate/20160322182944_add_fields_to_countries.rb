class AddFieldsToCountries < ActiveRecord::Migration
  def change
  	 add_column :countries, :price, :integer
  	 add_column :countries, :discount, :integer
  end
end
