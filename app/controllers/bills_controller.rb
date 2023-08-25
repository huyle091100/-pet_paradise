class BillsController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @bills = Bill.all
  end

  def show
  end
end
