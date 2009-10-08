
$:.unshift(File.expand_path('lib'))
$:.unshift(File.expand_path('~/w/ruota/lib'))

require 'ruote/http/app'

Ruote::Http::App.run!

