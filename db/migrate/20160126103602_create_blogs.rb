class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.attachment :preview
      t.text :content
      t.boolean :display

      t.timestamps null: false
    end
  end
end
