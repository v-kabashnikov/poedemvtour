class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.text :text
      t.string :site
      t.attachment :logo
      t.timestamps null: false
    end
  end
end
