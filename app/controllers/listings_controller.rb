class ListingsController < ApplicationController
  before_action :require_login, only: [:new]
  before_filter :set_page, only: [:index]
  RIPPLES_PER_PAGE = 15

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag])
    else
      # @listings = Listing.all
      if signed_in? && current_user.role == "admin"
        @listings = Listing.order(:created_at).limit(RIPPLES_PER_PAGE).offset(@page * RIPPLES_PER_PAGE)
      else
        @listings = Listing.where(status: "verified").order(:created_at).limit(RIPPLES_PER_PAGE).offset(@page * RIPPLES_PER_PAGE)
      end
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

  def update
    list = Listing.find(params[:id])
    list.update(status: "verified")
    redirect_to :back
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
    params.require(:listing).permit(:name, :location, :city, :pax_num, :price, {:tag_list => []}, :user_id)
  end

  def set_page
    @page = params[:page].to_i || 0
    if @page <= 0
      @page = 0
    elsif @page <= Listing.all.length / RIPPLES_PER_PAGE
      @page
    else
      @page = Listing.all.length / RIPPLES_PER_PAGE
    end
  end

end
