class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id, null: false, index: true
      t.integer :receiver_id, null: false, index: true
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
