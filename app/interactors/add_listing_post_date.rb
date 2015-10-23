class AddListingPostDate
  include Interactor
  require 'open-uri'

  def call
    if context.url = context.url
      doc = Nokogiri::HTML(open(context.url))
      date = doc.css('#display-date').text
      date = date.split(':')[1].strip.split.first.to_date
      context.date = date
    else
      context.fail!(message: "AddListingPostDate.failure")
    end
  end

  def self.fetch_listing_date(listing_id)
    listing = Listing.find(listing_id)
    doc = Nokogiri::HTML(open(listing.url))
    date = doc.css('#display-date').text
    date = date.split(':')[1].strip.split.first.to_date
  end

end
