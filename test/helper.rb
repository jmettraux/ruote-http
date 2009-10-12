
#
# testing ruote-http
#
# Thu Sep 10 22:40:26 JST 2009
#

ht_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(ht_lib) unless $:.include?(ht_lib)

ruote_lib = File.expand_path(File.join(%w[ ~ w ruota lib ]))
$:.unshift(ruote_lib) unless $:.include?(ruote_lib)
  #
  # TODO : ruote !

#require 'rubygems'

require 'test/unit'
require 'rack/test'

ENVIRONMENT = :test

require 'ruote/http/app'
require 'ruote/util/json'


module Rack::Test::Methods

  def setup

    conf_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'conf'))

    app.instance_eval do
      eval(File.read(File.join(conf_dir, 'engine.rb')))
      eval(File.read(File.join(conf_dir, 'participants.rb')))
    end
  end

  def teardown

    engine.shutdown
    engine.history.clear!
    FileUtils.rm_rf('work_test/') rescue nil
  end

  protected

  def app

    Ruote::Http::App
  end

  def engine

    app.engine
  end

  def launch_test_process

    pdef = Ruote.process_definition :name => 'test' do
      nada
    end

    wfid = engine.launch(pdef)

    sleep 0.400

    wfid
  end
end

class Rack::MockResponse

  def json_body

    Ruote::Json.decode(body)
  end
end

