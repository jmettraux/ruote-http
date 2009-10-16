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

    rendering_for :history
    rendering_for :history_range
    rendering_for :process_history

    def render_process_history_json (records)

      h = to_hash(records.collect { |r| r.to_h })

      h['links'] << link("/process/#{params[:wfid]}", rel('#process'))

      h.to_json
    end

    def render_process_history_html (records)

      raise 'implement me !'
    end

    def render_history_json (records)

      to_hash(records.collect { |r| r.to_h }).to_json
    end

    def render_history_html (records)

      raise 'implement me !'
    end

    def render_history_range_json (range)

      h = to_hash(nil)

      h['links'] << link(
        "/history/#{range.first.strftime('%F')}", rel('#history_last'))
      h['links'] << link(
        "/history/#{range.last.strftime('%F')}", rel('#history_first'))

      h.to_json
    end

    def render_history_range_html (range)

      raise 'implement me !'
    end
  end
end

