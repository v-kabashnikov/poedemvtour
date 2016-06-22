class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.date :date
      t.text :comment
      t.integer :people_number
      t.integer :rate
      t.references :hotel, index: true, foreign_key: true
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
