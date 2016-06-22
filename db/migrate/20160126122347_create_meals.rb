class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.string :alias
      t.text :description
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
