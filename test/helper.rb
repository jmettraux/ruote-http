
#
# testing ruote-http
#
# Thu Sep 10 22:40:26 JST 2009
#

ht_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(ht_lib) unless $:.include?(ht_lib)

ruote_lib = File.expand_path(File.join(%w[ ~ w ruota lib ]))
$:.unshift(ruote_lib) unless $:.include?(ruote_lib)

#require 'rubygems'

require 'test/unit'
require 'rack/test'

ENVIRONMENT = :test

require 'ruote/http/app'

