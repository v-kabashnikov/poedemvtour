class AddJsonToLoadStatus < ActiveRecord::Migration
  def change
    add_column :load_statuses, :results, :jsonb
  end
end
