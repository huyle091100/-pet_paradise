class ChatMessagesController < ApplicationController
  def create
    chat = Chat.where(sender_id: current_user.id, receiver_id: chat_message_param[:receiver_id]).or(Chat.where(sender_id: chat_message_param[:sender_id], receiver_id: current_user.id)).first
    chat.chat_messages.create! message: chat_message_param[:message], user_id: current_user.id
  end

  private

  def chat_message_param
    params.require(:chat_message).permit(:receiver_id, :message, :sender_id)
  end
end
