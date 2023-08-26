class Chat < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  enum status: [:unread, :read]
end
