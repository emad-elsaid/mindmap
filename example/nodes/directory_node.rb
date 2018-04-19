class DirectoryNode
  include Mindmap::Node

  attr_accessor :path

  def name
    File.basename(path)
  end

  def children_title
    path
  end

  def children
    Dir
      .entries(path)
      .sort
      .reject! { |file| ['.', '..'].include?(file) }
      .map { |file| child(File.expand_path(file, path)) }
  end

  def view
    :tag
  end

  private

  def child(file_path)
    return DirectoryNode.new(path: file_path) if File.directory?(file_path)

    FileNode.new(path: file_path)
  end
end
