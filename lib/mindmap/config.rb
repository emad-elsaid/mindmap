# frozen_string_literal: true

module Mindmap
  # hold the configuration for an application
  class Config
    def initialize(config)
      @config = config
    end

    def index
      layouts.first
    end

    def layouts
      config.fetch(:layouts, default_layouts)
    end

    private

    attr_accessor :config

    def default_layouts
      ['endless_scroll.html']
    end
  end
end
