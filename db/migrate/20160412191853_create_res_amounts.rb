class CreateResAmounts < ActiveRecord::Migration
  def change
    create_table :res_amounts do |t|
      t.integer :amount
      t.timestamps null: false
    end
  end
end
