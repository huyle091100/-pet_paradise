class BookingsController < ApplicationController
  def index
    
  end

  def create
    empty_room_ids = []
    rooms = Room.where(r_type: params[:r_type], weight: params[:weight])
    rooms.each do |room|
      bookings_quantity =  Booking.where(room_id: room.id).booked_r(booking_param[:started_at], booking_param[:finished_at]).sum(:quantity)
      if bookings_quantity + params[:quantity].to_i > room.quantity  
        next
      else
        empty_room_ids << room.id
      end
    end
    # if current_user.bookings.booked(booking_param[:started_at], booking_param[:finished_at]).present?
    #   flash[:notice] = "You have already booked within this time period"
    # els
    if empty_room_ids.present?
      Booking.create! room_id: empty_room_ids.first, started_at: booking_param[:started_at], finished_at: booking_param[:finished_at], user_id: current_user.id, quantity: params[:quantity]
      flash[:notice] = "Successfully!"
    else
      flash[:notice] = "The room you selected is sold out, please choose another room"
    end
    redirect_to bookings_path
  end

  def destroy
    Booking.find_by(id: params[:id]).destroy
    flash[:notice] = "Cancel booking successfully!"
    redirect_to bookings_path
  end

  private

  def booking_param
    params.require(:booking).permit :started_at, :finished_at
  end
end