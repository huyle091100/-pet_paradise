class Api::V1::BillsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    data = {
      status: 1,
      order_info: bill_params[:orderInfo],
      trans_id: bill_params[:transId],
      pay_type: bill_params[:payType],
      response_time: bill_params[:responseTime],
      message: bill_params[:message],
      result_code: bill_params[:resultCode],
    }

    bill = Bill.find_by(order_id: bill_params[:orderId])
    if bill
      if bill.update data
        render json: bill.to_json, status: 200
      else
        render json: {errors: bill.errors.full_messages.to_sentence}, status: 400
      end
    else
      render json: {errors: "Bill ot found"}, status: 404
    end
  end

  private

  def bill_params
    params.permit :orderId, :orderInfo, :transId, :payType, :responseTime, :message, :resultCode
  end
end
