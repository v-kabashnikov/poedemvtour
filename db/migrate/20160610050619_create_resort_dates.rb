class CreateResortDates < ActiveRecord::Migration
  def change
    create_table :resort_dates do |t|
      t.date :season_start
      t.date :season_end
      t.string :name
      t.string :site_name

      t.timestamps null: false
    end
  end
end
