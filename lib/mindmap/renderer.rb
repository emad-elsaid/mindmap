# frozen_string_literal: true

require 'erb'

module Mindmap
  # Renders a view file from either the library views
  # or the project views with a binding
  class Renderer
    def self.render(view, binding)
      renderer_instance(view).render(binding)
    end

    def self.renderer_instance(view)
      @renderers ||= {}
      @renderers[view] ||= new(view)
    end

    def initialize(view)
      @view = view
    end

    def render(binding)
      raise(StandardError, "#{view} view file not found") unless view_path
      erb.result(binding)
    end

    private

    attr_reader :view

    def erb
      @erb ||= ERB.new(view_content)
    end

    def view_content
      File.read(view_path)
    end

    def view_path
      view_paths.find { |file| File.exist?(file) }
    end

    def view_paths
      [
        File.expand_path("./nodes/#{view}.erb", Dir.pwd),
        File.expand_path("../../nodes/#{view}.erb", __dir__)
      ]
    end
  end
end
