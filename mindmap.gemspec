lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mindmap/version'

Gem::Specification.new do |spec|
  spec.name          = 'mindmap'
  spec.version       = Mindmap::VERSION
  spec.authors       = ['Emad Elsaid']
  spec.email         = ['emad.elsaid.hamed@gmail.com']

  spec.summary       = <<-SUMMARY
  A very specific and opinionated web framework to traverse a graph data structure
SUMMARY
  spec.description = <<-DESC
  A very specific and opinionated web framework to traverse a graph data structure
DESC
  spec.homepage      = 'https://github.com/emad-elsaid/mindmap'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'rack'
  spec.add_dependency 'thor'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
end
