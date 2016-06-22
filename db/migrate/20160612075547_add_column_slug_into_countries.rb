class AddColumnSlugIntoCountries < ActiveRecord::Migration
  def change
  	add_column :countries, :slug, :string, unique: true
  end
end
