class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: params[:user_id]).reverse
    render template: "reservations/index"
  end

  def new
    @house = Listing.find(params[:listing_id])
    @reservation = Reservation.new
    render template: "reservations/new"
  end

  def create
    # convert_date
    @reserve = Reservation.new(reserve_params)
    if @reserve.save
      redirect_to user_reservations_path(current_user)
    else
      flash[:error] = @reserve.errors.full_messages.join('. ')
      redirect_to :back
    end
  end

  private

  def reserve_params
    params.require(:reservation).permit(:checkin, :checkout, :guest_num, :user_id, :listing_id)
  end

  # def convert_date
  #   params[:reservation][:checkin].gsub!(/([0-9]+).([0-9]+).([0-9]+)/, '\2-\1-\3')
  #   params[:reservation][:checkout].gsub!(/([0-9]+).([0-9]+).([0-9]+)/, '\2-\1-\3')
  # end

end
