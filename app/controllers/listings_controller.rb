class ListingsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
    @listings = Listing.where(user_id: current_user.id)
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
    @listing = Listing.find(params[:id])
    render template: "listings/edit"
  end

  def update
    list = Listing.find(params[:id])
    if current_user.role == "admin"
      list.update(status: "verified")
      redirect_to :back
    else
      list.update(listing_params)
      redirect_to action: "index"
    end
  end

  def autocomplete
    search_term = params[:search].downcase
    # @listings = Listing.where("city LIKE ? ", "%#{search_term}%")
    @listings = Listing.search_city(search_term)
    # respond_to do |format|
    #   format.html { render action: "index" }
    #   format.js
    #   # format.json @results
    # end
    render action: "index"
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :location, :city, :pax_num, :price, {:tag_list => []}, :photos, :user_id)
  end
end
