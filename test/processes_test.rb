
#
# testing ruote-http
#
# Thu Sep 10 22:42:59 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')


class ProcessesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def teardown

    engine.purge!
    #FileUtils.rm_rf('work_test')
  end

  def app

    Ruote::Http::App
  end

  def test_processes_empty

    get '/processes'

    assert last_response.ok?

    h = last_response.json_body

    assert_equal 2, h.size
    assert_equal [], h['content']

    assert_equal 5, h['links'].size

    assert_equal(
      {"href"=>"/processes", "rel"=>"self"},
      h['links'].select { |h| h['rel'] == 'self' }.first)

    assert_equal 'application/json;charset=utf-8', last_response.content_type
  end

  def test_processes_slash

    get '/processes/'

    assert last_response.ok?
    assert_equal [], last_response.json_body['content']
  end

  def test_processes

    wfid = launch_test_process

    get '/processes'

    assert last_response.ok?

    h = last_response.json_body
    #p h

    assert_equal 1, h['content'].size
    assert_equal wfid, h['content'].first['wfid']
  end

  def test_process

    wfid = launch_test_process

    get "/processes/#{wfid}"

    assert last_response.ok?

    h = last_response.json_body
    #p h

    assert_equal 6, h['links'].size

    assert_equal(
      {"href"=>"/processes/#{wfid}", "rel"=>"self"},
      h['links'].select { |h| h['rel'] == 'self' }.first)
    assert_equal(
      "/history/#{wfid}",
      h['links'].select { |h| h['rel'].match(/#process_history$/) }.first['href'])

    assert_equal Hash, h['content'].class
  end

  def test_launch_process

    pdef = Ruote.process_definition :name => 'test' do
      nada
    end

    post(
      '/processes',
      pdef.to_json,
      { 'CONTENT_TYPE' => 'application/json;charset=utf-8' })

    assert_match /^\/processes\/.+$/, last_response.headers['Location']
    assert_match /^process .+ launched\.$/, last_response.json_body['content']

    sleep 0.400

    assert_equal 1, app::Engine.processes.size
    assert_equal 1, app::Engine.processes.first.errors.size
  end

  def test_cancel_process

    wfid = launch_test_process

    delete "/processes/#{wfid}"

    sleep 0.400

    assert_equal 0, app::Engine.processes.size
  end
end

