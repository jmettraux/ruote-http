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

  helpers do

    RELDOC = 'http://ruote.rubyforge.org/rels.html'

    def rel (fragment)

      "#{RELDOC}#{fragment}"
    end

    def self.rendering_for (res)

      eval %{
        def render_#{res} (o)

          f = rformat

          if f == 'json'
            content_type 'application/json', :charset => 'utf-8'
          else
            content_type 'text/html', :charset => 'utf-8'
          end

          send('render_#{res}_' + f, o)
        end
      }
    end

    def rformat

      accept = env['HTTP_ACCEPT']
      accept && accept.match('html') ? 'html' : 'json'
    end

    def link (href, rel)

      { 'href' => href, 'rel' => rel }
    end

    def links (res)

      [ link('/', rel('#root')), link(env['PATH_INFO'], 'self') ]
    end

    def to_json (res, o)

      { 'links' => links(res), 'content' => o }.to_json
    end
  end
end

