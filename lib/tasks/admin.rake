namespace :admin do
  desc 'REMOVE DUPLICATE DATA IDS FROM LISTINGS'
  task :remove_dupes => :environment do
    ids = Listing.unscoped.map(&:data_id)
    dupes = Listing.unscoped.select{|o| !ids.include?(o.data_id)}
    dupes.each{|d| d.destroy}
  end
end
