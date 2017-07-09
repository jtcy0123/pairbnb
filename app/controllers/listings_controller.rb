class ListingsController < ApplicationController
  before_action :require_login, only: [:new]
  # before_action :find_user, except: :index

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag])
    else
      @listings = Listing.all
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

  # def find_user
  #   User.find(params[:user_id])
  # end

end
