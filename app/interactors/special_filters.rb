class SpecialFilters
  include Interactor
  require 'open-uri'

  def call
    filter = false
    context.errors = 0
    context.num_filtered = 0
    listings = context.listings
    listing_filters = ListingFilter.all
    listings.each do |listing|
      begin
        doc = Nokogiri::HTML(open(listing.url))
        listing_filters.each do |listing_filter|
          if doc.css(listing_filter.css_selector).to_s.include?(listing_filter.text)
            filter = true
            context.num_filtered += 1
          end
        end
        listing.update_attributes(hide: true) if filter
      rescue OpenURI::HTTPError => ex
        context.errors += 1
      end
    end

  end

end
