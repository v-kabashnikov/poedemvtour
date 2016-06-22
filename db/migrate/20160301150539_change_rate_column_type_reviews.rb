class ChangeRateColumnTypeReviews < ActiveRecord::Migration
  def change
  	change_column :reviews, :rate, :float
  end
end
