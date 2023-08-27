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
    @chat = current_user&.has_role?(:admin) ? 
      Chat.includes(:chat_messages).where(receiver_id: current_user.id).order("chat_messages.created_at desc") : 
      Chat.includes(:chat_messages).where(sender_id: current_user&.id).order("chat_messages.created_at desc")
  end
end
