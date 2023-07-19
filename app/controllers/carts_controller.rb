class CartsController < ApplicationController
  include ActionView::RecordIdentifier
  include ActiveStorage::SetCurrent

  before_action :set_product, only: [:create, :update_quantity]
  def index
    products = current_user.carts.group(:product_id).count.keys
    @carts = Product.where(id: products)
  end

  def create
    respond_to do |format|
      if current_user.carts.create! cart_params
        @cart = current_user.carts.active.count
        format.turbo_stream
        # flash[:notice] = "Added a product to cart."
      else
        format.html
      end
    end
  end

  def update_quantity
    carts_active = current_user.carts.active.where(product_id: @product.id)
    if params[:quantity]&.to_i > carts_active.count
      add_carts = params[:quantity]&.to_i - carts_active.count
      add_carts.times do
        current_user.carts.create! product_id: @product.id
      end
    else
      remove_carts = carts_active.count - params[:quantity]&.to_i
      remove_carts.times do
        carts_active.first.destroy!
        carts_active.reload
      end
    end
    respond_to do |format|
        format.turbo_stream
        # flash[:notice] = "Added a product to cart."
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(cart_params[:product_id])
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.require(:cart).permit(:product_id, :user_id)
  end
end
