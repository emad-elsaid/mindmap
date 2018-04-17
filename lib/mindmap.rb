require 'active_support/all'

Dir[File.expand_path('../mindmap/**/*.rb', __FILE__)].each { |fl| require fl }
Dir[File.expand_path('./nodes/**/*.rb', Dir.pwd)].each { |fl| require fl }

module Mindmap
  def self.application
    app = Application.new
    public = Rack::Static.new(app, urls: [''], root: File.expand_path('../../public', __FILE__), index: 'index.html')

    Rack::Cascade.new([public, app])
  end
end
