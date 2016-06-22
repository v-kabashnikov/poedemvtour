class CreateTourRequests < ActiveRecord::Migration
  def change
    create_table :tour_requests do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :phone
      t.string :passnum
      t.string :issued
      t.string :issue_date
      t.string :valid_until
      t.string :hotel_id
      t.string :tour_id
      t.boolean :guest
      t.timestamps null: false
    end
  end
end
