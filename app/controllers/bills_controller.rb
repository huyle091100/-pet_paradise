class BillsController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @bills = Bill.all
  end

  def show
    @bill = Bill.find_by id: params[:id]
  end
end
