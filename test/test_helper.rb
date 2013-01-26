require 'bundler/setup'

require 'ap'
require 'pry'
require 'redis_gun'
require 'turn/autorun'

require 'redis_gun'

REDIS_SERVER ||= RedisGun::RedisServer.new
ENV['REDIS_URI'] = REDIS_SERVER.socket
def stop_redis_server
  REDIS_SERVER.stop
end
Signal.trap("SIGTERM", stop_redis_server)
Signal.trap("SIGINT", stop_redis_server)
Signal.trap("SIGQUIT", stop_redis_server)

MiniTest::Unit.after_tests do
  stop_redis_server
end

APP_ROOT = File.expand_path('../../', __FILE__)
$:.push "#{APP_ROOT}/lib"
