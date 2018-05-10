# frozen_string_literal: true

require 'json'

module Mindmap
  class Application
    def initialize(config)
      @config = config
    end

    def call(env)
      Request.new(env).response
    end

    private

    attr_accessor :config
  end
end
