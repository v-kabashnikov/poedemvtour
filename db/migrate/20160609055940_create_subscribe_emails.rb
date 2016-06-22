class CreateSubscribeEmails < ActiveRecord::Migration
  def change
    create_table :subscribe_emails do |t|
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
