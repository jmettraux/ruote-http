
#
# testing ruote-http
#
# Fri Oct  9 13:13:01 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')


class HistoryTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_history_empty

    get '/history'

    assert last_response.ok?
    assert_equal 5, last_response.json_body['links'].size
    assert_equal [], last_response.json_body['content']
  end

  def test_process_history_missing

    get '/history/20013-nada'

    assert last_response.ok?

    #p last_response.json_body

    assert_equal(
      '/history',
      last_response.json_body['links'].select { |l|
        l['rel'] == 'http://ruote.rubyforge.org/rel.html#history'
      }.first['href'])

    assert_equal [], last_response.json_body['content']
  end

  def test_process_history

    wfid = launch_test_process

    p wfid
    puts `ls -al work_test/log/`

    get "/history/#{wfid}"

    assert last_response.ok?

    assert_equal(
      "/process/#{wfid}",
      last_response.json_body['links'].select { |l|
        l['rel'] == 'http://ruote.rubyforge.org/rel.html#process'
      }.first['href'])

    assert_equal(
      "RuntimeError unknown expression 'nada'",
      last_response.json_body['content'].last['message'])
  end

  def test_history

    wfid = launch_test_process

    get '/history'

    #p last_response.body

    assert last_response.ok?

    flunk
  end
end

