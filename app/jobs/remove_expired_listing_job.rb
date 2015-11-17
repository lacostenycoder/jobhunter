class RemoveExpiredListingJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(*args)
    logger.debug "removing expired listing"
    id = self.arguments.first
    if listing = Listing.find_by_id(id)
      listing.remove_if_expired
    end
  end
end
