class Redis
  module CustomMethods

    def self.redis_obj
      uri = URI.parse(ENV["REDIS_URL"])
      redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      return redis
    end

  end
end
