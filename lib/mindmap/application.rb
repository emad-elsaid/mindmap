require 'json'

module Mindmap
  class Application
    def call(env)
      request = Rack::Request.new(env)

      [200, headers, [render_page(request)]]
    end

    private

    def render_page(request)
      node_name = request.path.camelize + 'Node'
      node_klass = node_name.constantize

      params = request.params.with_indifferent_access
      node = node_klass.new(params)
      node.children.map(&:render).join
    end

    def headers
      {
        'Content-Type' => 'text/html;charset=utf-8'
      }
    end
  end
end
