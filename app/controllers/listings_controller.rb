class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @junior = Listing.junior.sort_by(&:post_date).reverse
    @ruby = Listing.rubyrails.sort_by(&:post_date).reverse
    @listings = Listing.current.sort_by(&:post_date).reverse
    @listings = (@listings - @ruby - @junior)
    respond_with(@listings, @junior, @ruby)
  end

  def get_post_dates
    @listings = Listing.all
    @listings.each do |listing|
      RemoveExpiredListingJob.perform_later(listing.id)
    end
    redirect_to :root
  end

  def do_filters
    # scoped to ruby but remove scope to filter over all listings
    #Listing.delay.run_filters
    redirect_to :root, notice: "Running filters..."
  end

  def purge_all
    if params[:password] && params[:password] == ENV['PURGE_LISTING_PASSWORD']
      #Listing.delete_all
      redirect_to :root, notice: "All Listings Removed!"
    else
      redirect_to :root, notice: "Invalid Password!"
    end
  end

  def search
    @listings = Listing.search(params[:search])
  end

  def get_new
    GetNewListingsJob.perform_later
    redirect_to listings_path, notice: "Fetching listings... check back soon"
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
