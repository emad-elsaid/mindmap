# frozen_string_literal: true

class RootNode < DirectoryNode
  def initialize(*)
    super(path: '/')
  end
end
