class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id
      t.string :email
      t.string :unsubscribe_token

      t.timestamps null: false
    end
  end
end
