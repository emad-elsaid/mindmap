$LOAD_PATH << File.expand_path(__dir__)

require 'bundler'
Bundler.setup(:default)

require 'active_support/all'

# Load all mind mapper source files
Dir[File.expand_path('mind_mapper/**/*.rb', __dir__)].each { |file| require file }
