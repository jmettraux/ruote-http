#!/usr/bin/env ruby

require 'rubygems'
require 'json'

HOST = 'http://localhost:4567'


def curl (res, data=nil, opts={})

  options = []

  options << '-v -s -o out.tmp'

  if data
    options << "-d #{data.inspect}"
  end
  if ct = opts[:content_type]
    options << "-H \"Content-Type: #{ct}\""
  end
  if ac = opts[:accept]
    options << "-H \"Accept: #{ac}\""
  end
  if m = opts[:method]
    options << "-X #{m.upcase}"
  end

  cmd = "curl #{options.join(' ')} #{HOST}#{res}"
  puts
  puts "===" + cmd
  puts
  system(cmd)
  puts

  File.read('out.tmp')
end

curl('/processes')

pdef = [ 'define', { 'name' => 'test' }, [
  [ 'nada', {}, [] ]
] ]

curl('/processes', pdef.to_json)

