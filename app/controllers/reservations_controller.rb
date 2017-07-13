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
    indate = params[:reservation][:checkin].to_date
    outdate = params[:reservation][:checkout].to_date
    date = []
    while indate < outdate
      date << indate.to_s
      indate += 1
    end
    if Reservation.where(listing_id: params[:reservation][:listing_id]).where(checkin: date) == []
      @reserve = Reservation.new(reserve_params)
      if @reserve.save
        # redirect_to user_reservations_path(current_user)
        redirect_to listing_reservation_path(params[:reservation][:listing_id], @reserve.id)
      else
        flash[:error] = @reserve.errors.full_messages.join('. ')
        redirect_to :back
      end
    else
      flash[:msg] = "room are not available on these dates"
      redirect_to :back
    end
  end

  def show
    @house = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
    render template: "reservations/show"
  end

  private

  def reserve_params
    params.require(:reservation).permit(:checkin, :checkout, :guest_num, :user_id, :listing_id)
  end


end
