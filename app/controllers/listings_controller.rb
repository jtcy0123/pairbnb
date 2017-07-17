class ListingsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
    if signed_in?
      @listings = Listing.where(user_id: current_user.id)
    else
      redirect_to sign_in_path
    end
  end

  def new
    @listing = Listing.new
    # @listing = @user.listings.new
    render template: "listings/new"
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to action: "index"
      # redirect_to [@user, @listing]
    else
      render action: "new"
    end
  end

  def show
    @house = Listing.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    if signed_in?
      @listing = Listing.find(params[:id])
      render template: "listings/edit"
    else
      redirect_to sign_in_path
    end
  end

  def update
    list = Listing.find(params[:id])
    if current_user.role == "admin"
      list.update(status: "verified")
      redirect_to :back
    else
      list.update(update_params)
      if params[:listing][:photos] != nil
        list.photos += params[:listing][:photos]
        list.save
      else
        list.update(photos: params[:listing][:photos])
      end
      list.update(status: "unverified")
      redirect_to action: "index"
    end
  end

  def autocomplete
    if signed_in?
      @from = params[:checkin]
      @until = params[:checkout]
      @reservation = Reservation.new
      indate = @from.to_date
      outdate = @until.to_date
      if !indate.nil? && !outdate.nil?
        date = []
        while indate < outdate
          date << indate.to_s
          indate += 1
        end
      end
      @booked = Reservation.where(checkin: date)
      @listings = Listing.where(status: "verified").search_city(params[:search].downcase)
      # respond_to do |format|
      #   format.html { render action: "index" }
      #   format.js
      #   # format.json @results
      # end
      render template: "welcome/book"
    else
      redirect_to sign_in_path
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :location, :city, :pax_num, :price, {:tag_list => []}, {:photos => []}, :user_id)
  end

  def update_params
    params.require(:listing).permit(:name, :location, :city, :pax_num, :price, {:tag_list => []})
  end
end
