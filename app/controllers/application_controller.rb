class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_default_limit, only: [:index, :shop]
  before_action :set_chat

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You are not authorized to access this page!"
    redirect_to root_path
  end

  def set_cart
    @cart =  current_user ? current_user.carts.active.count : 0
  end

  def set_default_limit
    @limit = params[:limit] || 12
  end

  def set_chat
    @chat = current_user&.has_role?(:admin) || current_user&.has_role?(:staff) ? 
    Chat.joins(:chat_messages).where(receiver_id: nil).order("chat_messages.created_at desc").uniq :
    Chat.where(sender_id: current_user&.id).first&.chat_messages.present? ? Chat.joins(:chat_messages).where(sender_id: current_user&.id).order("chat_messages.created_at desc").uniq : Chat.where(sender_id: current_user&.id)
  end
end
