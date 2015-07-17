namespace :import do
  desc 'import tasks from Craigslist'
  task :craigslist => :environment do
    if Rails.env == "production"
      Listing.update_from_craigslist.delay
    else
      Listing.update_from_craigslist
    end
    ListingMailer.junior_email(ENV['DEFAULT_EMAIL']).deliver_now
  end
end
