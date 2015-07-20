class Listing < ActiveRecord::Base

  after_create :fix_url

  scope :current, -> { where("created_at >= ?", Time.now - 72.hours) }
  scope :recent, -> { where("created_at >= ?", Time.now - 6.hours) }
  scope :junior, -> { where("lower(description) ILIKE ?", '%junior%') }

  #scope :today, -> { where("created_at >= ? AND created_at < ?", Date.today, Date.tomorrow) }

  def self.default_scope
    where(:hide=> false)
  end

  def self.rubyrails
     Listing.find_by_sql("select * from listings where lower(description) ILIKE '%ruby%' or lower(description) ILIKE '%rails%'")
     .select{|l| !l.hide}
  end

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

  def is_new?
    self.created_at >= Time.zone.now - 5.hour
  end

  def self.from_cl(data)
    if data[:description].include? "xundo"
      data[:description] = data[:description].gsub(/xundo/, '')
    end
    listing = Listing.new(data)
    listing.fix_url
  end

  def fix_url
    malformed = self.url.match('http://newyork.craigslist.orghttp:')
    if malformed
      self.url = "http:" + self.url.gsub(malformed.to_s, '')
      self.save
    end
  end

end
