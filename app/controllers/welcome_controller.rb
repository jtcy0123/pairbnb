class WelcomeController < ApplicationController
  before_filter :set_page, only: [:index]
  LISTINGS_PER_PAGE = 15

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag])
    else
      # @listings = Listing.all
      if signed_in? && current_user.role == "admin"
        @listings = Listing.order('created_at DESC').limit(LISTINGS_PER_PAGE).offset(@page * LISTINGS_PER_PAGE)
      else
        @listings = Listing.where(status: "verified").order('created_at DESC').limit(LISTINGS_PER_PAGE).offset(@page * LISTINGS_PER_PAGE)
      end
    end
  end

  private

  def set_page
    if current_user && current_user.role == "admin"
      listing = Listing.all
    else
      listing = Listing.where(status: "verified")
    end
    @page = params[:page].to_i || 0
    if @page <= 0
      @page = 0
    elsif @page <= listing.length / LISTINGS_PER_PAGE
      @page
    else
      @page = listing.length / LISTINGS_PER_PAGE
    end
  end

end
