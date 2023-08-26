class CartsController < ApplicationController
  include ActionView::RecordIdentifier
  include ActiveStorage::SetCurrent

  before_action :set_product, only: [:create, :update_quantity]
  before_action :total, only: [:index, :checkout_momo, :checkout]
  def index
    products = current_user.carts.active.group(:product_id).count.keys
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
    @total = 0
    current_user.carts.active.includes(:product).each do |l_prod|
      @total += l_prod.product.price
    end
    @cart = current_user.carts.active.count
    respond_to do |format|
        format.turbo_stream
        # flash[:notice] = "Added a product to cart."
    end
  end

  def checkout_momo
    momo = Momo::GetPaymentUrlService.call({user: current_user, amount: @total, carts: @carts, params: params})
    if momo["resultCode"] == 0
      redirect_to momo["payUrl"], allow_other_host: true
    else
      flash[:notice] = "Checkout momo fail!"
      redirect_to carts_path
    end
  end

  def checkout
    products = current_user.carts.active.group(:product_id).count.keys
    @products = Product.where(id: products)
  end

  def destroy
      carts = current_user.carts.active.where product_id: params[:id]
      carts.update_all status: :inactive
      flash[:notice] = "Remove cart successfully!"
      redirect_to carts_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(cart_params[:product_id])
  end

  def total
    @carts = current_user.carts
    @total = 0
    current_user.carts.active.includes(:product).each do |l_prod|
      @total += l_prod.product.price
    end
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.require(:cart).permit(:product_id, :user_id)
  end
end
