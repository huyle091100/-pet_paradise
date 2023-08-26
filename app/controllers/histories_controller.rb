class HistoriesController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @histories = current_user.bills.all.order(created_at: :desc)
  end

  def show
    @bill_products = current_user.bills.find_by(id: params[:id]).bill_products
    @carts = Product.where(id: @bill_products.pluck(:product_id))
  end
end