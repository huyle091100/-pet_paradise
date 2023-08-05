class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{current_user.id}_channel"
    # stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  #
  # def get_user_data
  #   data = {
  #     id: current_user.id,
  #     email: current_user.email,
  #     user_name: current_user.email.split('@')[0]
  #   }
  #
  #   ActionCable.server.broadcast "#{current_user.id}", data
  # end

  # def speak(data)
  #   binding.pry
  #   message_params = data['message'].each_with_object({}) do |el, hash|
  #     hash[el.values.first] = el.values.last
  #   end
  #
  #   ChatMessage.create(message_params)
  # end
end
