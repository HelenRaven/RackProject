require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'middleware/rack_time'
require_relative 'app'

#use Runtime
#use AppLogger, logdev: File.expand_path('log/app.log', __dir__)

map '/time' do
  use RackTime
  run App.new
end
