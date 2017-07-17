class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservationID)
    reservation = Reservation.find(reservationID)
    ReservationMailer.booking_email(reservation).deliver
  end
end
