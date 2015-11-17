class Listing < ActiveRecord::Base

  has_and_belongs_to_many :keywords, uniq: true
  validates_presence_of :data_id, uniq: true
  after_create :fix_url, :join_keywords

  scope :current, -> { where("post_date >= ?", (Time.now - 7.days).to_date) }
  scope :recent, -> { where("post_date >= ?", (Time.now - 3.days).to_date) }
  scope :junior, -> { where("lower(description) ILIKE ?", '%junior%') }
  scope :ruby, -> { where("lower(description) ILIKE ?", '%ruby%') }
  scope :no_post_date, -> { where(post_date: nil) }

  #scope :today, -> { where("created_at >= ? AND created_at < ?", Date.today, Date.tomorrow) }

  def self.default_scope
    Listing.where(:hide=> false).order('post_date DESC')
  end

  def self.rubyrails
    listings_ruby = Listing.ruby.uniq
    listing_rails = Listing.where("lower(description) ILIKE ?", '%rails%').current.uniq
    listings = listings_ruby + listing_rails
    listings.flatten.uniq
  end

  def self.purge_old(num_days)
    old_listings = Listing.unscoped.where("post_date < ?", (Time.now - num_days.days).to_date)
    old_listings.each{|listing| listing.destroy}
  end

  def self.update_from_craigslist
    keywords = Keyword.all.map(&:word)
    new_jobs = []
    listings = Listing.unscoped.load
    imported_ids = listings.empty? ? Array.new : listings.map(&:data_id)
    jobs_from_craigslist = fetch_jobs(keywords).select{|cl| !imported_ids.include? cl[:data_id] }
    jobs_from_craigslist.each do |job|
      p job.inspect
      unless (job[:description].downcase.split(' ') & Keyword.hidden.map(&:word.downcase)).length > 0
        Listing.from_cl(job)
      end
    end
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
    results.flatten.uniq
  end

  def is_new?
    self.created_at >= Time.zone.now - 5.hour
  end

  def self.from_cl(data)
    if data[:description].include? "xundo"
      data[:description] = data[:description].gsub(/xundo/, '')
    end
      listing = Listing.unscoped.first_or_initialize(data_id: data[:id])
    unless listing.persisted?
      listing.update_attributes(data)
      listing.fix_url
      listing.save
    end
  end

  def fix_url
    self.url = "http://" + self.url.split('//').last
    malformed = self.url.match('http://newyork.craigslist.orghttp:')
    if malformed
      self.url = "http:" + self.url.gsub(malformed.to_s, '')
    end
    self.save if self.changed?
  end

  def fetch_post_date
    result = AddListingPostDate.call(url: self.url)
    if result.date
      self.update_attributes(post_date: result.date)
    elsif result.doc = 404
      self.destroy
    else
      self.update_attributes(hide: true)
    end
  end

  def remove_if_expired
    return if updated_at >= (Time.now - 7.days).to_datetime
    require 'open-uri'
    begin
      doc = Nokogiri::HTML(open(self.url))
    rescue Exception => error
      self.destroy if error.message == "404 Not Found"
      p error.message
      return
    end
    date = doc.css('#display-date').text
    if date == ""
      self.destroy
    else
      date = date.split(':')[1].strip.split.first.to_date
      update_attributes(post_date: date)
    end
  end

  def self.run_filters
    listings = Listing.all
    SpecialFilters.call(listings: listings)
  end

  def join_keywords
    keywords = Keyword.unscoped.select{|keyword| self.description.downcase.include? keyword[:word].downcase}
    self.keywords << keywords
  end

  def set_hidden
    self.update_attributes(hide: true)
  end

  def set_visable
    self.update_attributes(hide: false)
  end

  def self.search(search)
    if search
      Listing.where('lower(description) LIKE ?', "%#{search.downcase}%")
    else
      Listing.all
    end
  end

  def self.get_last_hidden
    Listing.unscoped.where(hide: true).order('updated_at DESC').first
  end

end
