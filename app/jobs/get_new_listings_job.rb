class GetNewListingsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Listing.update_from_craigslist
  end
end
