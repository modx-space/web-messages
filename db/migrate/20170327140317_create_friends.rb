class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
