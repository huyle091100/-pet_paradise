
require "uri"
require "net/http"

class Momo::GetPaymentUrlService < ApplicationService
  def initialize args = {}
    @user = args[:user]
    @amount = args[:amount]
  end

  def call
    random_token = SecureRandom.hex(10)
    extra_data = Base64.encode64(JSON.dump({orderId: "MM2023_#{user.id}_#{random_token}"}))
    order_id = "MM2023_#{user.id}_#{random_token}"
    request_id = "MM2023-#{user.id}-#{random_token}"
    text_to_sha = "accessKey=7tYPQ3NQMFtdtTdE&amount=#{amount}&extraData=#{extra_data}&ipnUrl=#{Rails.application.secrets.dig(:assets_host)}&orderId=#{order_id}&orderInfo=#{user.email}&partnerCode=MOMOVEIT20200928&redirectUrl=#{Rails.application.secrets.dig(:assets_host)}&requestId=#{request_id}&requestType=captureWallet"
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.hexdigest(digest, 'akzjoOpoNooEjYqahEveiV8n2iOIzlBr', text_to_sha)
    data_body = {
      partnerCode: "MOMOVEIT20200928",
      storeName: "Pet Paradise",
      storeId: "MoMoTestStore",
      requestType: "captureWallet",
      ipnUrl: Rails.application.secrets.dig(:assets_host),
      redirectUrl: Rails.application.secrets.dig(:assets_host),
      orderId: order_id,
      amount: amount,
      lang:  "vi",
      orderInfo: user.email,
      requestId: "MM2023-#{user.id}-#{random_token}",
      extraData: extra_data,
      signature: hmac
    }
    url = URI("https://test-payment.momo.vn/v2/gateway/api/create")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump(data_body)
    response = https.request(request)
    JSON.parse(response.body)
  end

  private

  def items

  end

  attr_reader :user, :amount
end