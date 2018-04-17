require 'active_support/all'

Dir[File.expand_path('mindmap/**/*.rb', __dir__)].each { |fl| require fl }

module Mindmap
  def self.application
    app = Application.new
    public = Rack::Static.new(app, urls: [''], root: 'public', index: 'index.html')

    Rack::Cascade.new([public, app])
  end
end
