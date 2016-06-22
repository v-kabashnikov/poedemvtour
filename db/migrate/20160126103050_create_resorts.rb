class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.string :name
      t.string :alias
      t.boolean :display
      t.references :country, index: true, foreign_key: true
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
