require 'rails_helper'

RSpec.describe AddListingPostDate, type: :interactor do
  subject(:context) { AddListingPostDate.call(url: "http://newyork.craigslist.org/mnh/sof/5268779806.html") }
  describe ".call" do
    it "should return a date" do
      expect(context.date).to be_kind_of(Date)
    end
  end
end
