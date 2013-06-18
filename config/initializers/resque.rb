if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

# module ActiveRecord
#   class LogSubscriber
#     alias old_logger logger
#     def logger
#       l = old_logger
#       puts("Calling logger and returning: " + l.inspect) unless louis_debug_flag
#       @louis_debug_flag = true
#       l
#     end
#     
#     def louis_debug_flag
#       @louis_debug_flag ||= false
#     end
#   end
# end
# 
# puts "Rails logger is: " + Rails.logger.inspect
# puts "ActiveSupport::LogSubscriber.logger is: " + ActiveSupport::LogSubscriber.logger.inspect
# puts "ActiveRecord::Base.logger is: " + ActiveRecord::Base.logger.inspect