
#
# testing ruote-http
#
# Tue Oct  6 22:12:34 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')


class IndexTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def teardown

    engine.purge!
    #FileUtils.rm_rf('work_test')
  end

  def app

    Ruote::Http::App
  end

  def test_processes_empty

    get '/'

    assert last_response.ok?

    h = last_response.json_body

    assert_equal 5, h['links'].size

    assert_equal(
      {"href"=>"/", "rel"=>"self"},
      h['links'].select { |h| h['rel'] == 'self' }.first)
  end
end

