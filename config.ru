require ::File.expand_path('../config/application', __FILE__)

use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Static, urls: { '/' => 'index.html', '/favicon.ico' => 'favicon.ico' }, root: 'public'

run Mindmap.application
