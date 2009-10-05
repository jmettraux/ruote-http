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

require 'sinatra'
require 'json'


module Ruote
module Http

  class App < Sinatra::Base

    set :environment, defined?(ENVIRONMENT) ? ENVIRONMENT : :production

    ht_dir = File.expand_path(File.join(File.dirname(__FILE__), *%w[ .. ] * 3))

    #
    # set root

    set(:root, File.join(ht_dir, 'www'))

    #
    # load conf

    conf_dir = File.join(ht_dir, 'conf')

    [
      File.join(conf_dir, "#{environment}.rb"),
      File.join(conf_dir, 'common.rb')
    ].each { |path| configure { eval(File.read(path)) } }

    #
    # initialize engine

    Engine = engine_class.new(engine_options)

    #
    # participants

    # TODO

    #
    # load reply / representations code

    load(File.join(ht_dir, *%w[ lib ruote http render.rb ]))

    rep_dir = File.join(ht_dir, *%w[ lib ruote http rep ])

    Dir[File.join(rep_dir, '*.rb')].each { |path| load(path) }

    #
    # load resources code

    res_dir = File.join(ht_dir, *%w[ lib ruote http res ])

    Dir[File.join(res_dir, '*.rb')].each { |path| load(path) }
  end
end
end

