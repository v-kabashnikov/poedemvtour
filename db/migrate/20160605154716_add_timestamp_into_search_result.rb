class AddTimestampIntoSearchResult < ActiveRecord::Migration
  def change
    change_table :search_results do |t|
  	  t.timestamps
  	end

  	SearchResult.update_all(created_at: Time.now, updated_at: Time.now)

  	change_column_null :search_results, :created_at, false
  	change_column_null :search_results, :updated_at, false
  end
end
