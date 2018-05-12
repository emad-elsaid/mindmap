# frozen_string_literal: true

class RootNode
  include Mindmap::Node

  def children
    [DirectoryNode.new(path: '/')]
  end
end
