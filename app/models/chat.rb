class Chat < ApplicationRecord
  has_many :chat_messages
  enum status: [:unread, :read]
end
