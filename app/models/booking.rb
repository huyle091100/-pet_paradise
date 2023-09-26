class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :booked, -> (started_at, finished_at){where("bookings.started_at BETWEEN ? and ?", started_at.to_date, finished_at.to_date).or(Booking.where("bookings.finished_at BETWEEN ? and ?", started_at.to_date, finished_at.to_date))}
  scope :booked_r, -> (started_at, finished_at){where("? BETWEEN bookings.started_at and bookings.finished_at", started_at.to_date).or(Booking.where("? BETWEEN bookings.started_at and bookings.finished_at", finished_at.to_date)).or(booked(started_at, finished_at))}
  end
