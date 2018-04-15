class FileNode
  include MindMapper::Node

  attr_accessor :path

  def children
    return [] if file?

    entries = Dir.entries(path)
    entries.reject! do |file|
      file == '.' || file == '..'
    end

    entries.map do |file|
      FileNode.new(path: File.expand_path(file, path))
    end
  end

  def name
    File.basename(path)
  end

  def dir?
    File.directory?(path)
  end

  def file?
    File.file?(path)
  end
end
