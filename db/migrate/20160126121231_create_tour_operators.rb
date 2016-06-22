class CreateTourOperators < ActiveRecord::Migration
  def change
    create_table :tour_operators do |t|
      t.string :name
      t.attachment :logo
      t.string :site
      t.string :address
      t.string :phone
      t.text :description
      t.attachment :header_img
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
