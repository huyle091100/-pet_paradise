class AddStatusToChatMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_messages, :status, :integer, default: 0
    remove_column :chats, :status
  end
end
