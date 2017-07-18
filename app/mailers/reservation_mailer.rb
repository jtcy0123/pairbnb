class ReservationMailer < ApplicationMailer
  def booking_email(reservation)
    @listing = Listing.find(reservation.listing_id)
    @booked = User.find(reservation.user_id)
    @reservation = reservation
    @user = User.find(@listing.user_id)
    @url = "http://bibnb.herokuapp.com/reservations." + @user.id.to_s
    mail(to: @user.email, subject: "New Booking For Your House")
    # flash[:msg] = "Email sent!"
  end
end
