class ManageBookingsController < ApplicationController
  def index
    authorize! :access, Booking
    @apartment = Room.apartment #apartment, :vip, :penthouse
    @vip = Room.vip
    @penthouse = Room.penthouse
    @bookings = Booking.where("? BETWEEN bookings.started_at and bookings.finished_at", params[:mdate]&.to_date || Time.now)
  end
end