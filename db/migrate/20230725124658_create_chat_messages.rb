class CreateChatMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_messages do |t|
      t.integer :chat_id
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end
end
