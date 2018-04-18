require 'active_support/all'

Dir[File.expand_path('./mindmap/**/*.rb', __dir__)].each { |fl| require fl }
Dir[File.expand_path('./nodes/**/*.rb', Dir.pwd)].each { |fl| require fl }

module Mindmap
  def self.application
    apps = []

    apps.unshift Application.new
    apps.unshift Rack::Static.new(apps.first, urls: [''], root: File.expand_path('../public', __dir__), index: 'index.html')


    project_public = File.expand_path('./public', Dir.pwd)

    if File.exist?(project_public)
      apps.unshift Rack::Static.new(apps.first, urls: [''], root: project_public, index: 'index.html')
    end

    Rack::Cascade.new(apps)
  end
end
