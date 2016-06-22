class CreateLoadStatuses < ActiveRecord::Migration
  def change
    create_table :load_statuses do |t|
      t.integer :request_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
