class CreateErrorSubscribes < ActiveRecord::Migration
  def change
    create_table :error_subscribes do |t|
      t.string :email, null: false

      t.timestamps null: false
    end

    ErrorSubscribe.create!(email: 'jujava@mail.ru')
  end
end
