class ApplicationController < ActionController::Base
  before_action :set_cart
  before_action :set_default_limit, only: [:index, :shop]

  def set_cart
    @cart =  current_user ? current_user.carts.active.count : 0
  end

  def set_default_limit
    @limit = params[:limit] || 12
  end
end
