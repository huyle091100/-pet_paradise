class WelcomeController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @cart = 1
  end

  def shop
    @products = Product.all
  end
end
