class ReservationMailer < ApplicationMailer
  def booking_email(reservation)
    listing = Listing.find(reservation.listing_id)
    @user = User.find(listing.user_id)
    mail(to: @user.email, subject: "New Booking For Your House")
  end
end
