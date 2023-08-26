class BillsController < ApplicationController
  load_and_authorize_resource
  include ActiveStorage::SetCurrent

  def index
    @bills = Bill.all.order(created_at: :desc)
  end

  def show
    @bill = Bill.find_by id: params[:id]
  end

  def update
    @bill = Bill.find_by id: params[:id]
    @bill.update! is_shipped: true
    flash[:notice] = "Mark shipped successfully!"
    respond_to do |format|
      format.js { render js: "window.location.href = '/bills';" }
    end
  end
end
