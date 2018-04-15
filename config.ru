require_relative 'boot'

use Rack::Static, urls: ['/stylesheet', '/javascript'], root: 'public'
use Rack::Static, urls: { '/' => 'index.html', '/favicon.ico' => 'favicon.ico' }, root: 'public'

run MindMapper::Application.new
