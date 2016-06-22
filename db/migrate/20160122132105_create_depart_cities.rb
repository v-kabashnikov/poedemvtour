class CreateDepartCities < ActiveRecord::Migration
  def change
    create_table :depart_cities do |t|
      t.string :name
      t.string :alias
      t.boolean :display
      t.integer :sletat_id
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
