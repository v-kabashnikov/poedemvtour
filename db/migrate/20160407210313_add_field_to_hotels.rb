class AddFieldToHotels < ActiveRecord::Migration
  def change
  	add_column :hotels, :result_description, :text
  end
end
