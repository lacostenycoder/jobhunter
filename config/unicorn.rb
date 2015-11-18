worker_processes 3

preload_app true
timeout 300

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
  Sidekiq.configure_client do |config|
    config.redis = {  url: 'redis://dokku-redis-rails-redis:6379/0', :size => 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://dokku-redis-rails-redis:6379/0', :size => 2 }
  end
end
