# frozen_string_literal: true

require 'erb'

module Mindmap
  # a module that must be included to any graph node
  # it has methods needed by the framework to render the node
  module Node
    include ERB::Util

    def initialize(params = {})
      assign_params(params)
    end

    # assign a hash values to attributes with the same name
    def assign_params(params)
      params.each do |key, value|
        if self.class.public_method_defined?("#{key}=")
          public_send("#{key}=", value)
        end
      end
    end

    # renders the node ERB view file and returns the result
    def render(format = :html)
      Renderer.render("#{view}.#{format}", binding)
    end

    # The path to the view file relative to the "views" directory
    # by default the file is the class name underscored e.g
    # if node class is `Graph::NodeName` it returns `graph/node_name`
    def view
      self.class.name.underscore
    end

    # returns the node url that could be used for a link
    def url
      '/' + self.class.name.underscore.gsub('_node', '')
    end
  end
end
