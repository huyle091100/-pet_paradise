class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart
    @cart =  current_user ? current_user.carts.active.count : 0
  end
end
