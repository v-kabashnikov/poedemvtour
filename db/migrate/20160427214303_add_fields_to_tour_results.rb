class AddFieldsToTourResults < ActiveRecord::Migration
  def change
  	add_column :tour_results, :offer_id, :string
  	add_column :tour_results, :source_id, :string
  	change_column_null :tour_results, :created_at, true
  	change_column_null :tour_results, :updated_at, true
  end
end
