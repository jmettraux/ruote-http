
#
# testing ruote-sin
#
# Thu Sep 10 22:42:59 JST 2009
#

require File.join(File.dirname(__FILE__), 'helper.rb')


describe 'ruote-sin /processes' do

  #def app
  #  Ruote::Sin::App.new
  #end

  it 'should be alright' do

    get '/processes'
    should.be.ok
    body.should.equal('processes')
  end
end

