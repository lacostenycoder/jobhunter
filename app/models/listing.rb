class Listing < ActiveRecord::Base

  has_and_belongs_to_many :keywords, uniq: true

  after_create :fix_url, :join_keywords

  scope :current, -> { where("created_at >= ?", Time.now - 7.days) }
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
    results.flatten.uniq
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
    listing.save unless listing.persisted?
  end

  def fix_url
    malformed = self.url.match('http://newyork.craigslist.orghttp:')
    if malformed
      self.url = "http:" + self.url.gsub(malformed.to_s, '')
      self.save
    end
  end

  def join_keywords
    keywords = Keyword.unscoped.select{|keyword| self.description.downcase.include? keyword[:word]}
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
