#--
# Copyright (c) 2005-2009, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++


class Ruote::Http::App

  get '/processes' do

    render_processes(Engine.processes)
  end

  get '/processes/' do

    render_processes(Engine.processes)
  end

  post '/processes' do

    o = get_input

    # TODO : remember, with some JSON parsers only {} is OK on the outside...

    wfid = if o.is_a?(Array)
      # process definition

      Engine.launch(o)

    elsif o.is_a?(Hash)
      # launchitem

      nil

    elsif o.is_a?(String)
      # process definition URI

      nil

    else
      # :(

      raise "argh!"

    end

    status 201
    headers 'Location' => "/processes/#{wfid}"
      # TODO : too absolute !!

    render_message("process #{wfid} launched.")
  end

  get '/processes/:wfid' do

    render_process(Engine.process(params[:wfid]))
  end

  #get '/processes/:wfid/errors' do
  #end
    #
    # simply get /processes/:wfid

  delete '/processes/:wfid' do

    wfid = params[:wfid]

    Engine.cancel_process(wfid)

    "process #{wfid} cancelled."
  end
end

