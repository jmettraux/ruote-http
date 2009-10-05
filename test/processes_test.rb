
#
# testing ruote-http
#
# Thu Sep 10 22:42:59 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')


class ProcessesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def teardown

    engine.shutdown rescue nil
    engine.context.values.each { |s| s.purge if s.respond_to?(:purge) }
    FileUtils.rm_rf('work_test')
  end

  def app

    Ruote::Http::App
  end

  def test_processes_empty

    get '/processes'

    assert last_response.ok?

    h = last_response.json_body

    assert_equal(
      {"links"=>[{"href"=>"/", "rel"=>"http://ruote.rubyforge.org/ruote-http.html#root"}, {"href"=>"/processes", "rel"=>"self"}], "content"=>[]},
      h)
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
end

