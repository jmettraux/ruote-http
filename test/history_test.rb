
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
    assert_equal [], last_response.json_body['history']
  end

  def test_history_range

    get '/history/range'

    assert last_response.ok?
    assert_equal 7, last_response.json_body['links'].size

    assert_equal(
      "/history/#{Time.now.strftime('%F')}",
      last_response.json_body['links'].select { |l|
        l['rel'] == 'http://ruote.rubyforge.org/rel.html#history_first'
      }.first['href'])

    assert_equal(
      "/history/#{Time.now.strftime('%F')}",
      last_response.json_body['links'].select { |l|
        l['rel'] == 'http://ruote.rubyforge.org/rel.html#history_last'
      }.first['href'])

    assert_equal nil, last_response.json_body['history_range']
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

    assert_equal [], last_response.json_body['history']
  end

  def test_process_history

    wfid = launch_test_process

    get "/history/#{wfid}"

    #p last_response.json_body

    assert last_response.ok?

    assert_equal(
      "/process/#{wfid}",
      last_response.json_body['links'].select { |l|
        l['rel'] == 'http://ruote.rubyforge.org/rel.html#process'
      }.first['href'])

    assert_equal(
      "RuntimeError unknown expression 'nada'",
      last_response.json_body['history'].last['message'])
  end

  def test_history

    wfid = launch_test_process

    get '/history'

    assert last_response.ok?
    assert_equal 2, last_response.json_body['history'].size
  end

  def test_history_date

    wfid = launch_test_process

    get "/history/#{Time.now.strftime('%F')}"

    assert last_response.ok?
    assert_equal 2, last_response.json_body['history'].size

    get "/history/#{(Time.now + 60 * 60 * 25).strftime('%F')}"

    assert last_response.ok?
    assert_equal 0, last_response.json_body['history'].size
  end
end

