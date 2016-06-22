class AddFieldsToFlight < ActiveRecord::Migration
  def change
  	add_column :flights, :arrival_airport, :string
  	add_column :flights, :flight_number, :string
  end
end
