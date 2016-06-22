class Hz < ActiveRecord::Migration
  def change
  	create_table :question_categories do |t|
  	  t.string :category
      t.timestamps null: false
    end
    create_table :questions do |t|
  	  t.string :head
  	  t.string :body
      t.timestamps null: false
    end
     add_reference :questions, :question_category, index: true
  end
end
