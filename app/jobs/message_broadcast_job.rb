class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = User.find_by id: message.user_id
    recipient = User.find_by(id: message.user_id == message.chat.receiver_id ? message.chat.sender_id : message.chat.receiver_id )

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
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