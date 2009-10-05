
#
# testing ruote-http
#
# Thu Sep 10 22:42:59 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')

class ProcessesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app

    Ruote::Http::App
  end

  def test_processes

    get '/processes'
    assert last_response.ok?
    assert_equal '{ links : [], content: [] }', last_response.body
  end
end

