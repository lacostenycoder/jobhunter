class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @junior = Listing.junior.reverse
    @ruby = Listing.rubyrails.reverse
    @listings = Listing.current.reverse
    @listings = (@listings - @ruby - @junior)
    respond_with(@listings, @junior, @ruby)
  end

  def get_new
    Listing.update_from_craigslist
    @listings = Listing.recent
  end

  def hide
    @listing = Listing.find(params[:id])
    @listing.update_attributes(hide: true)
    respond_to :js
  end

  def show
    respond_with(@listing)
  end

  def new
    @listing = Listing.new
    respond_with(@listing)
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
    respond_with(@listing)
  end

  def update
    @listing.update(listing_params)
    respond_with(@listing)
  end

  def destroy
    @listing.destroy
    respond_with(@listing)
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:description, :url, :hide)
    end
end
