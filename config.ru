require_relative 'boot'

use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Static, urls: { '/' => 'index.html', '/favicon.ico' => 'favicon.ico' }, root: 'public'

run Mindmap::Application.new
