# frozen_string_literal: true

module Mindmap
  class Request < Rack::Request
    def response
      [200, response_headers, response_body]
    end

    def params
      super.with_indifferent_access
    end

    private

    def response_body
      [node_children.map { |child| child.render(response_type) }.join]
    end

    def response_headers
      {
        'Content-Type' => "#{response_format};charset=utf-8"
      }
    end

    def response_type
      case response_format
      when 'text/html'
        :html
      when 'image/svg+xml'
        :svg
      else
        :html
      end
    end

    def response_format
      get_header('HTTP_ACCEPT') || 'text/html'
    end

    def node_children
      @node_children ||= node.children
    end

    def node
      @node ||= node_klass.new(params)
    end

    def node_klass
      (path.camelize + 'Node').constantize
    end
  end
end
