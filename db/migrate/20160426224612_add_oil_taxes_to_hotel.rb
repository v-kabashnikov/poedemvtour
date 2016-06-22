class AddOilTaxesToHotel < ActiveRecord::Migration
  def change
  	 create_table :oil_taxes do |t|
      t.string :start_date 
      t.string :finish_date
      t.string :amount
      t.string :currency
      t.references :hotel, index: true, foreign_key: true
      t.timestamps null: false
  	end
  end
end
