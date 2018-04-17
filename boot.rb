$LOAD_PATH << File.expand_path(__dir__)

require 'bundler'
Bundler.setup(:default)

require 'active_support/all'

# Load all mind map source files
Dir[File.expand_path('mindmap/**/*.rb', __dir__)].each { |fl| require fl }
