# frozen_string_literal: true

require 'thor'
require 'fileutils'

module Mindmap
  class CLI < Thor
    include Thor::Actions

    desc 'new PROJECT_NAME', 'Create a new mindmap project'
    def new(name)
      directory('example', name)

      inside(name) do
        run('bundle install')
      end
    end

    desc 'server', 'Start a web server'
    def server
      trap(:INT) { exit }
      run('rackup', verbose: false)
    end
  end
end
