class AddFieldsToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :reviews, :moderated, :boolean, :default => true
  end
end
