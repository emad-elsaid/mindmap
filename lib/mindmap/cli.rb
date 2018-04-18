require 'thor'
require 'fileutils'

module Mindmap
  class CLI < Thor
    desc 'new PROJECT_NAME', 'Create a new mindmap project'
    def new(name)
      src = File.expand_path('../../example', __dir__)
      dst = File.join(Dir.pwd, name)

      raise StandardError, "#{name} directory already exists" if File.exist?(dst)
      FileUtils.cp_r(src, dst)
    end
  end
end
