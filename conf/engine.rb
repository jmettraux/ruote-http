
# initialization (and final configuration) of the ruote engine happens here

Engine = engine_class.new(engine_options)

require 'ruote/log/fs_history'

Engine.add_service(:s_history, Ruote::FsHistory.new)

