require 'erb'

module Mindmap
  # Renders a view file from either the library views
  # or the project views with a binding
  class Renderer
    class << self
      def render(view, binding)
        erb(view).result(binding)
      end

      private

      def erb(view)
        @erb ||= {}
        @erb[view] ||= ERB.new(view_content(view))
      end

      def view_content(view)
        view_path = view_paths(view).find { |file| File.exist?(file) }
        raise(StandardError, "#{view} view file not found") unless view_path
        File.read(view_path)
      end

      def view_paths(view)
        [
          File.expand_path("./views/#{view}.html.erb", Dir.pwd),
          File.expand_path("../../views/#{view}.html.erb", __dir__)
        ]
      end
    end
  end
end
