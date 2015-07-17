namespace :import do
  desc 'import tasks from Craigslist'
  task :craigslist => :environment do

    Listing.update_from_craigslist
    ListingMailer.junior_email(ENV['DEFAULT_EMAIL']).deliver_now
  end
end
