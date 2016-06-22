class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.string :name
      t.string :alias
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
