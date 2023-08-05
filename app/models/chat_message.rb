class ChatMessage < ApplicationRecord
  belongs_to :chat
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
