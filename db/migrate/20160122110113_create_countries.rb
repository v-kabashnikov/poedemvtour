class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :alias
      t.attachment :flag
      t.attachment :header_img
      t.boolean :display
      t.references :country_category, index: true, foreign_key: true
      t.integer :sletat_id

      t.timestamps null: false
    end
  end
end
