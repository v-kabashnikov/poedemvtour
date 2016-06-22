class CreateResortDatesResorts < ActiveRecord::Migration
  def change
    create_table :resort_dates_resorts do |t|
      t.integer :resort_date_id
      t.integer :resort_id

      t.timestamps null: false
    end
  end
end
