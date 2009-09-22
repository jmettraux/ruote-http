# this configuration is evaluated last

require 'ruote/engine/fs_engine'

configure do

  set :engine_class, Ruote::FsPersistedEngine
end

