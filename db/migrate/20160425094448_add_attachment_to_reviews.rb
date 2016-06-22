class AddAttachmentToReviews < ActiveRecord::Migration
    create_table :revimgs do |t|
      t.attachment :image
      t.references :review, index: true, foreign_key: true
      

      t.timestamps null: false
    end
end
