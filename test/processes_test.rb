
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

    assert_equal([
      {"href"=>"/", "rel"=>"http://ruote.rubyforge.org/rels.html#root"},
      {"href"=>"/processes", "rel"=>"self"}
    ], h['links'])

    assert_equal 'application/json;charset=utf-8', last_response.content_type
  end

  def test_processes

    pdef = Ruote.process_definition :name => 'test' do
      nada
    end

    wfid = engine.launch(pdef)

    sleep 0.400

    get '/processes'

    assert last_response.ok?

    h = last_response.json_body
    #p h

    assert_equal 1, h['content'].size
    assert_equal wfid, h['content'].first['wfid']
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

    sleep 0.400

    assert_equal 1, app::Engine.processes.size
    assert_equal 1, app::Engine.processes.first.errors.size
  end
end

