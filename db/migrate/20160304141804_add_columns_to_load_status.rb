class AddColumnsToLoadStatus < ActiveRecord::Migration
  def change
  	add_reference :load_statuses, :depart_city, index: true, foreign_key: true
  	add_reference :load_statuses, :country, index: true, foreign_key: true
  	add_column :load_statuses, :depart_from, :date
  	add_column :load_statuses, :adults, :integer
  	add_column :load_statuses, :kids, :integer
  	add_column :load_statuses, :nights, :string
  end
end
