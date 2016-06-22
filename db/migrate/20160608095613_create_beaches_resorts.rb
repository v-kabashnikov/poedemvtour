class CreateBeachesResorts < ActiveRecord::Migration
  def change
    create_table :beaches_resorts do |t|
      t.integer :beach_id, null: false
      t.integer :resort_id, null: false

      t.timestamps null: false
    end
  end
end
