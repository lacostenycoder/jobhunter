class RemoveExpiredListingJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    id = self.arguments.first
    if listing = Listing.find_by_id(id)
      listing.remove_if_expired
    end    
  end
end
