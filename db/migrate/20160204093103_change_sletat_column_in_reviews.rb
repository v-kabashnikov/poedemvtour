class ChangeSletatColumnInReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :sletat_id
    add_column :reviews, :sletat, :boolean
  end
end
