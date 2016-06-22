class CreateTourResults < ActiveRecord::Migration
  def change
    create_table :tour_results do |t|
      t.references :hotel, index: true, foreign_key: true
      t.date :depart_date
      t.integer :nights
      t.string :depart_city
      t.string :meal
      t.string :tour_operator
      t.string :room_type
      t.integer :request_id
      t.integer :price
      t.integer :adults_number
      t.integer :children_number
      t.string :sletat_id

      t.timestamps null: false
    end
  end
end
