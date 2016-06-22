class AddReferenceToBlog < ActiveRecord::Migration
  def change
  	add_reference :blogs, :blog_category, index: true
  end
end
