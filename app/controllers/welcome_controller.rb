class WelcomeController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    if current_user && current_user.has_role?(:admin)
      redirect_to users_path
    else
      @cart = current_user ? current_user.carts.active.count : 0
    end
  end

  def shop
    @products = Product.all.page(params[:page] || 1).per(@limit).order(created_at: :desc)
  end
end
