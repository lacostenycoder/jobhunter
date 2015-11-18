web: bundle exec unicorn -p $PORT -E $RAILS_ENV -c ./config/unicorn.rb
worker: bundle exec sidekiq -e $RAILS_ENV -C config/sidekiq.yml 
