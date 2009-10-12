
# initialization (and final configuration) of the ruote engine happens here

@engine = engine_class.new(engine_options.dup)

require 'ruote/log/fs_history'

@engine.add_service(:s_history, Ruote::FsHistory.new)

