# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://dokku-redis-rails-redis:6379/0' }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://dokku-redis-rails-redis:6379/0' }
# end
if ENV['RAILS_ENV'] == 'production'
  Sidekiq.configure_client do |config|
    config.redis = {  url: 'redis://dokku-redis-rails-redis:6379/0', :size => 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://dokku-redis-rails-redis:6379/0', :size => 2 }
  end
end
