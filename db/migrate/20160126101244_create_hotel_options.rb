class CreateHotelOptions < ActiveRecord::Migration
  def change
    create_table :hotel_options do |t|
      t.attachment :icon
      t.string :name
      t.string :hit
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
