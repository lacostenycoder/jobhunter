web: bundle exec unicorn -p $PORT -E $RAILS_ENV -c ./config/unicorn.rb
worker: bundle exec sidekiq -e production -C config/sidekiq.yml -e $RAILS_ENV
