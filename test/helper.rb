
#
# testing ruote-sin
#
# Thu Sep 10 22:40:26 JST 2009
#

hit_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(hit_lib) unless $:.include?(hit_lib)

ruote_lib = File.expand_path(File.join(%w[ ~ w ruota lib ]))
$:.unshift(ruote_lib) unless $:.include?(ruote_lib)

#require 'rubygems'

require 'test/unit'
require 'rack/test'

ENVIRONMENT = :test

require 'ruote/hit/app'

