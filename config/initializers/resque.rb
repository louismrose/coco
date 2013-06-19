if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

# The following code seems to prevent a strange error that seems to occur with
# when running the InstanceRunner Resque worker on Heroku: instance.save fails
# with an exception that seems to be cause by ActiveSupport::LogSubscriber attempting
# to access a logger which is unavailable (nil is returned). I suspect that this is
# because, for some reason, ActiveRecord::Base.logger is returning nil. Perhaps
# forcing Rails to access (and hence initialise?) ActiveRecord::Base.logger during the
# startup of the thread that will run the workers prevents a race condition?
# 
puts "ActiveRecord::Base.logger is: " + ActiveRecord::Base.logger.inspect