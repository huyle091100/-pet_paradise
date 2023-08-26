class ManageBookingsController < ApplicationController
  def index
    @apartment = Room.apartment #apartment, :vip, :penthouse
    @vip = Room.vip
    @penthouse = Room.penthouse
    @booking_room_ids = Booking.where("? BETWEEN bookings.started_at and bookings.finished_at", params[:mdate]&.to_date || Time.now).pluck(:room_id)
  end
end