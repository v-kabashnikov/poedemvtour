class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :hotel, index: true, foreign_key: true
      t.integer :request_id
      t.integer :min_price
    end
  end
end
