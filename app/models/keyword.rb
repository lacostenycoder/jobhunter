class Keyword < ActiveRecord::Base

  has_and_belongs_to_many :listings, uniq: true

  after_save :set_listings

  def self.default_scope
    where(:hide=> false)
  end

  def self.hidden
     Keyword.unscoped.where("hide", 'true')
  end

  def associate_listings
    listings = Listing.unscoped.search(self.word)
    self.listings << listings
  end

  def set_listings
    associate_listings
    if self.hide
      self.hide_listings
    else
      self.show_listings
    end
  end

  def hide_listings
    self.listings.each{|listing| listing.set_hidden}
  end

  def show_listings
    self.listings.each{|listing| listing.set_visable}
  end

end
