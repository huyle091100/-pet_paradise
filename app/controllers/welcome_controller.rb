class WelcomeController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @cart = 1
  end

  def shop
    @products = Product.all.page(params[:page] || 1).per(@limit).order(created_at: :desc)
  end
end
