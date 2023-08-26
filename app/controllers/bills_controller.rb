class BillsController < ApplicationController
  load_and_authorize_resource
  include ActiveStorage::SetCurrent

  def index
    @bills = Bill.all.order(created_at: :desc)
  end

  def show
    @bill = Bill.find_by id: params[:id]
  end
end
