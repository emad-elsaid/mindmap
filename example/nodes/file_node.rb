# frozen_string_literal: true

class FileNode
  include Mindmap::Node

  attr_accessor :path

  def name
    File.basename(path)
  end
end
