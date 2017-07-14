class BraintreeController < ApplicationController
  def new
    @reservation = Reservation.find(params[:format])
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
      :amount => Reservation.find(params[:checkout_form][:reservation_id]).total.to_i, #this is currently hardcoded
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      reservation = Reservation.find(params[:checkout_form][:reservation_id])
      ReservationMailer.booking_email(reservation).deliver
      reservation.update(payment_status: "paid")
      redirect_to user_reservations_path(current_user), :flash => { :success => "Transaction successful!" }
    else
      redirect_to :back, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
