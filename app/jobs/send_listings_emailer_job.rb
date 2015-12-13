class SendListingsEmailerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    ListingMailer.listings_email(ENV['DEFAULT_EMAIL'], Listing.recent.email_last_sent.to_a).deliver_now
    rubyjobs = Listing.ruby
    if rubyjobs.length > 0
      ListingMailer.listings_email(ENV['DEFAULT_EMAIL'], rubyjobs.email_last_sent.to_a).deliver_now
    end
    sent = EmailSent.create({sent_at: Time.now})
  end
end
