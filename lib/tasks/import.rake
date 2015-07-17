namespace :import do
  desc 'import tasks from Craigslist'
  task :craigslist => :environment do

    Listing.update_from_craigslist
    
end
