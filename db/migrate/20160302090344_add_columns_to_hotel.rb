class AddColumnsToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :sletat_image_urls, :string, array: true, default: []
    add_column :hotels, :building_date, :integer
    add_column :hotels, :distance_to_lifts, :integer
    add_column :hotels, :rooms_count, :integer
    add_column :hotels, :square, :integer
  end
end
