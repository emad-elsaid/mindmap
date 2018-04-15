class FileNode
  include MindMapper::Node

  attr_accessor :path

  def name
    File.basename(path)
  end

  def view
    :tag
  end
end
