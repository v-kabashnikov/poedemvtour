class CreateFacilityGroups < ActiveRecord::Migration
  def change
    create_table :facility_groups do |t|
      t.string :name
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
