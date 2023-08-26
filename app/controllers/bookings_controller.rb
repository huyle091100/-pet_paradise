class BookingsController < ApplicationController
  def index
    
  end

  def create
    room_ids = Room.where(r_type: params[:r_type], weight: params[:weight]).pluck(:id)
    bookings =  Booking.where(room_id: room_ids).booked(booking_param[:started_at], booking_param[:finished_at])
    empty_room_ids = room_ids - bookings.pluck(:room_id)
    if empty_room_ids.present?
      Booking.create! room_id: empty_room_ids.first, started_at: booking_param[:started_at], finished_at: booking_param[:finished_at], user_id: current_user.id
      flash[:notice] = "Successfully!"
    else
      flash[:notice] = "The room you selected is sold out, please choose another room"
    end
    redirect_to bookings_path
  end

  private

  def booking_param
    params.require(:booking).permit :started_at, :finished_at
  end
end