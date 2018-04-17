require 'active_support/all'

Dir[File.expand_path('mindmap/**/*.rb', __dir__)].each { |fl| require fl }

module Mindmap
  def self.application
    @application ||= Application.new
  end
end
