class ReservationsController < ApplicationController
  def index
    if signed_in?
      if params[:format]
        @listings = Listing.where(user_id: current_user.id)
        @reservations = Reservation.where(listing_id: @listings.pluck(:id))
      else
        @reservations = Reservation.where(user_id: current_user.id)
      end
      render template: "reservations/index"
    else
      redirect_to sign_in_path
    end
  end

  def new
    if signed_in?
      @house = Listing.find(params[:listing_id])
      @reservation = Reservation.new
      render template: "reservations/new"
    else
      redirect_to sign_in_path
    end
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
        total_price = Listing.find(@reserve.listing_id).price * (@reserve.checkout - @reserve.checkin).to_i
        @reserve.update(total: total_price)
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
    if signed_in?
      @house = Listing.find(params[:listing_id])
      @reservation = Reservation.find(params[:id])
      render template: "reservations/show"
    else
      redirect_to sign_in_path
    end
  end

  private

  def reserve_params
    params.require(:reservation).permit(:checkin, :checkout, :guest_num, :user_id, :listing_id)
  end


end
