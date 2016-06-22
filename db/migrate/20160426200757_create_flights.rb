class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :date
      t.string :time
      t.string :operator
      t.references :hotel, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
