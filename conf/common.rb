# common configuration (evaluated last)

require 'ruote/engine/fs_engine'

set :engine_class, Ruote::FsPersistedEngine

use Rack::CommonLogger
use Rack::ShowExceptions

