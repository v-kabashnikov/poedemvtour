class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.references :resort, index: true, foreign_key: true
      t.string :old_cyrillic_name
      t.string :old_latin_name
      t.string :subtitle
      t.attachment :photo
      t.string :sletat_photo_url
      t.float :hotel_rate
      t.integer :rating_meal
      t.integer :rating_overall
      t.integer :rating_place
      t.integer :rating_service
      t.string :sletat_description
      t.text :description
      t.string :video
      t.float :city_center_distance
      t.string :beach_line
      t.string :district
      t.float :latitude
      t.float :longitude
      t.float :airport_distance
      t.integer :min_price
      t.references :star, index: true, foreign_key: true
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
