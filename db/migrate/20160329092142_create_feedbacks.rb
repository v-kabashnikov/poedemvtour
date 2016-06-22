class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.text :body
      t.integer :rating
      t.attachment :background
      t.timestamps null: false
    end
  end
end
