class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :booked, -> (started_at, finished_at){where("bookings.started_at BETWEEN ? and ?", started_at.to_date, finished_at.to_date).or(Booking.where("bookings.finished_at BETWEEN ? and ?", started_at.to_date, finished_at.to_date))}
  end
