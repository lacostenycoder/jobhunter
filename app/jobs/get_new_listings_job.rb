class GetNewListingsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Listing.update_from_craigslist
    listings = Listing.no_post_date
    listings.each{| l | l.fetch_post_date}
    Listing.run_filters
    SendListingsEmailerJob.perform_now
  end
end
