class ListingMailer < ApplicationMailer

  def junior_email(email)
    @junior_listings = Listing.junior
  end

end
