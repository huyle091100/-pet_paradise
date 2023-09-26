class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    user = User.find_by(id: message.user_id)
    if user.has_role?(:admin) || user.has_role?(:staff)
      recipients = User.where(id: message.chat.sender_id)
      recipients = recipients + (User.with_any_role(:staff, :admin) - User.where(id: message.user_id))
    else
      recipients = User.with_any_role(:staff, :admin)
    end
    sender = User.find_by id: message.user_id

    broadcast_to_sender(sender, message)
    recipients.each do |recipient|
      broadcast_to_recipient(recipient, message)
    end
  end

  private

  def broadcast_to_sender(user, message)
    # broadcast_append_to message.chat, :chat_messages, target: "chat_messages"
    ActionCable.server.broadcast(
      "chat_#{user.id}_channel",
      {chat_message: render_message(message, user),
       chat_id: message.chat_id}
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "chat_#{user.id}_channel",
      # window: render_window(message.conversation, user),
      {chat_message: render_message(message, user),
       chat_id: message.chat_id}
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'chat_messages/chat_message',
      locals: { chat_message: message, current_user: user }
    )
  end
  #
  # def render_window(conversation, user)
  #   ApplicationController.render(
  #     partial: 'conversations/conversation',
  #     locals: { conversation: conversation, user: user }
  #   )
  # end
end