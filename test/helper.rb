
#
# testing ruote-sin
#
# Thu Sep 10 22:40:26 JST 2009
#

sin_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(sin_lib) unless $:.include?(sin_lib)

#require 'rubygems'

require 'test/unit'
require 'rack/test'
require 'ruote/sin/app'

set :environment, :test

