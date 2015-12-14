class GetNewListingsJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(*args)
    Listing.update_from_craigslist
    listings = Listing.no_post_date
    listings.each{| l | l.fetch_post_date}
    logger.info "Listings pulling from Craigslist at #{Time.now}"
    Listing.run_filters
    SendListingsEmailerJob.set(wait_until: (Time.now + 15.minutes)).perform_later
  end
end
