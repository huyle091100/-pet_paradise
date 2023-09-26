class ChatMessage < ApplicationRecord
  belongs_to :chat
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  enum status: [:unread, :read]
end
