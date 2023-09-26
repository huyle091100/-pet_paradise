class ChatMessagesController < ApplicationController
  def create
    chat = Chat.where(sender_id: current_user.id).or(Chat.where(sender_id: chat_message_param[:sender_id])).first
    chat.chat_messages.create! message: chat_message_param[:message], user_id: current_user.id
  end

  private

  def chat_message_param
    params.require(:chat_message).permit(:message, :sender_id)
  end
end
