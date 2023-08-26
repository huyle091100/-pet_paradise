
require "uri"
require "net/http"

class Momo::GetPaymentUrlService < ApplicationService
  def initialize args = {}
    @user = args[:user]
    @amount = args[:amount]
    @carts = args[:carts]
    @data_cart = carts.active.group(:product_id).count(:product_id)
    @products = Product.where(id: data_cart.keys)
    @params = args[:params]
  end

  def call
    random_token = SecureRandom.hex(10)
    extra_data = Base64.encode64(JSON.dump({orderId: "MM2023_#{user.id}_#{random_token}"}))
    order_id = "MM2023_#{user.id}_#{random_token}"
    request_id = "MM2023-#{user.id}-#{random_token}"
    text_to_sha = "accessKey=7tYPQ3NQMFtdtTdE&amount=#{amount}&extraData=#{extra_data}&ipnUrl=#{Rails.application.secrets.dig(:assets_host)}/api/v1/bills&orderId=#{order_id}&orderInfo=#{user.email}&partnerCode=MOMOVEIT20200928&redirectUrl=#{Rails.application.secrets.dig(:assets_host)}/shop&requestId=#{request_id}&requestType=captureWallet"
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.hexdigest(digest, 'akzjoOpoNooEjYqahEveiV8n2iOIzlBr', text_to_sha)
    data_body = {
      partnerCode: "MOMOVEIT20200928",
      storeName: "Pet Paradise",
      storeId: "MoMoTestStore",
      requestType: "captureWallet",
      ipnUrl: "#{Rails.application.secrets.dig(:assets_host)}/api/v1/bills",
      redirectUrl: "#{Rails.application.secrets.dig(:assets_host)}/shop",
      orderId: order_id,
      amount: amount,
      lang:  "vi",
      orderInfo: user.email,
      requestId: "MM2023-#{user.id}-#{random_token}",
      extraData: extra_data,
      signature: hmac,
      items: items
    }
    url = URI("https://test-payment.momo.vn/v2/gateway/api/create")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump(data_body)
    response = https.request(request)

    if JSON.parse(response.body)["resultCode"] == 0
      bill = Bill.create order_id: order_id, amount: amount, order_info: user.email, status: :unpaid, user_id: user.id, 
        first_name: params[:first_name], last_name: params[:last_name], address: params[:address], phone_number: params[:phone_number]
      products.each do |product|
        bill.bill_products.create product_id: product.id, name: product.name, quantity: data_cart[product.id], total_amount: product.price * data_cart[product.id]
      end
      carts.update_all status: :inactive
    end
    JSON.parse(response.body)
  end

  private

  def items
    items = []
    products.each do |product|
      items << {id: SecureRandom.hex(5), name: product.name, currency: "VND", quantity: data_cart[product.id], totalAmount: product.price * data_cart[product.id], purchaseAmount: product.price * data_cart[product.id]}
    end
    items
  end

  attr_reader :user, :amount, :carts, :products, :data_cart, :params
end