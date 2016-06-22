class AddColumnsToSearchResult < ActiveRecord::Migration
  def change
    add_column :search_results, :meal, :string
    add_column :search_results, :depart_date, :string
    add_column :search_results, :nights, :integer
  end
end
