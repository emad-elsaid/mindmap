class FileNode
  include Mindmap::Node

  attr_accessor :path

  def name
    File.basename(path)
  end

  def view
    :tag
  end
end
