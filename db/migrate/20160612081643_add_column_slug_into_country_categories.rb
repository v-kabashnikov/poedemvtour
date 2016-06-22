class AddColumnSlugIntoCountryCategories < ActiveRecord::Migration
  def change
  	add_column :country_categories, :slug, :string, unique: true
  end
end
