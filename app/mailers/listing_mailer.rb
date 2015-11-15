class ListingMailer < ApplicationMailer

  def listings_email(email, listings)
    @listings = listings
    mail(to: email)
  end

end
