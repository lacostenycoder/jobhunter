class ListingsController < ApplicationController

  def index
    @listings = Listing.all
    @junior = Listing.junior
  end

end
