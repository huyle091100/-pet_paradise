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
    q = params[:category]
    qq = params[:q]
    @products = q ? Product.where(category: q) : Product.all
    @products = qq ? @products.where("products.name like ? or products.category like ?", "%#{qq}%", "%#{Product.categories[qq] || Product.categories.values}%") : @products
    @products = @products.page(params[:page] || 1).per(@limit).order(created_at: :desc)
  end

  def shop_detail
    @product = Product.find_by id: params[:id]
  end
end
