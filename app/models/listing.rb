class Listing < ActiveRecord::Base

  default_scope { where :hide => false && :create_at >= (Time.now - 72.hours) }

  scope :junior, -> { where("lower(description) ILIKE ?", '%junior%') }

  def self.update_from_craigslist
    keywords = Keyword.all.map(&:word)
    new_jobs = []
    listings = Listing.unscoped.load
    imported_ids = listings.empty? ? Array.new : listings.map(&:data_id)
    jobs_from_craigslist = fetch_jobs(keywords).select{|cl| !imported_ids.include? cl[:data_id] }
    puts jobs_from_craigslist.to_yaml
    jobs_from_craigslist.each{|job| Listing.from_cl(job)}
  end

  def self.fetch_jobs(keywords)
    require 'craigslist'
    cl = Craigslist.new
    results = []
    options={city: 'newyork'}
    keywords.each do |k|
      result = cl.search_city_jobs(options, k)
      results << result
    end
    results = results.flatten!
    results = results.uniq!
    return results
  end

  def self.from_cl(data)
    if data[:description].include? "xundo"
      data[:description] = data[:description].gsub(/xundo/, '')
    end
    listing = Listing.create(data)
  end

end
