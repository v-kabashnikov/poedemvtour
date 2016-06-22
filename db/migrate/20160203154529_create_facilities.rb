class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.attachment :icon
      t.references :facility_group, index: true, foreign_key: true
      t.string :hit
      t.integer :sletat_id

      t.timestamps null: false
    end
    create_table :facilities_hotels, id: false do |t|
      t.belongs_to :facility, index: true
      t.belongs_to :hotel, index: true
    end
    add_index :facilities_hotels, [:facility_id, :hotel_id], unique: true
    add_index :facilities_hotels, [:hotel_id, :facility_id], unique: true
  end
end
