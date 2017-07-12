class WelcomeController < ApplicationController
  before_filter :set_page, only: [:index]
  LISTINGS_PER_PAGE = 8

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag]).where(status: "verified").order('created_at DESC').limit(LISTINGS_PER_PAGE).offset(@page * LISTINGS_PER_PAGE)
      @lists = Listing.tagged_with(params[:tag]).where(status: "verified")
    else
      if signed_in? && current_user.role == "admin"
        @listings = Listing.where(status: "unverified").order('created_at DESC').limit(LISTINGS_PER_PAGE).offset(@page * LISTINGS_PER_PAGE)
        @lists = Listing.where(status: "unverified")
      else
        @listings = Listing.where(status: "verified").order('created_at DESC').limit(LISTINGS_PER_PAGE).offset(@page * LISTINGS_PER_PAGE)
        @lists = Listing.where(status: "verified")
      end
    end
  end

  private

  def set_page
    @page = params[:page].to_i || 0
  end

end
