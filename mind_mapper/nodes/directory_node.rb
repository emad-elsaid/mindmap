class DirectoryNode
  include MindMapper::Node

  attr_accessor :path

  def name
    File.basename(path)
  end

  def children_title
    path
  end

  def children
    entries = Dir.entries(path).sort
    entries.reject! do |file|
      file == '.' || file == '..'
    end

    entries.map do |file|
      child(File.expand_path(file, path))
    end
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
