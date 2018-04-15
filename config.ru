require_relative 'boot'

use Rack::Static, urls: ['/stylesheet', '/javascript'], root: 'public'
use Rack::Static, urls: { '/' => 'index.html' }, root: 'public'

run MindMapper::Application.new
