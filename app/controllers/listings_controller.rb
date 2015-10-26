class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @junior = Listing.junior
    @ruby = Listing.rubyrails
    @listings = Listing.current
    @listings = (@listings - @ruby - @junior)
    respond_with(@listings, @junior, @ruby)
  end

  def get_post_dates
    @listings = Listing.all
    @listings.each do |listing|
      next if listing.post_date
      result = AddListingPostDate.call(url: listing.url)
      if result.date
        listing.update_attributes(post_date: result.date)
      else
        listing.destroy
      end
    end
    redirect_to :root
  end

  def do_filters
    # scoped to ruby but remove scope to filter over all listings
    listings = Listing.rubyrails
    result = SpecialFilters.call(listings: listings)
    if result.num_filtered > 0
      flash[:notice] = result.num_filtered.to_s + ' listings have been filtered!'
    else
      flash[:notice] = "No filtered items found."
    end
    redirect_to :root

  end

  def search
    @listings = Listing.search(params[:search])
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

  def undo_hide
    @listing = Listing.get_last_hidden
    @listing.update_attributes(hide: false)
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
