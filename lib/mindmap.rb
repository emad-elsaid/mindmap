# frozen_string_literal: true

require 'active_support/all'
require 'rack'

Dir[File.expand_path('./mindmap/**/*.rb', __dir__)].each { |fl| require fl }
Dir[File.expand_path('./nodes/**/*.rb', Dir.pwd)].each { |fl| require fl }

module Mindmap
  def self.application
    apps = []

    apps.unshift Application.new
    lib_public = File.expand_path('../public', __dir__)
    apps.unshift(
      Rack::Static.new(
        apps.first,
        urls: [''],
        root: lib_public,
        index: 'index.html'
      )
    )

    local_public = File.expand_path('./public', Dir.pwd)

    if File.exist?(local_public)
      apps.unshift(
        Rack::Static.new(
          apps.first,
          urls: [''],
          root: local_public,
          index: 'index.html'
        )
      )
    end

    Rack::Cascade.new(apps)
  end
end
