class ChangeCountryPriceType < ActiveRecord::Migration
  def change
  	change_column :countries, :price,  :string
  end
end
