#!/usr/bin/env ruby

$:.unshift File.expand_path '../../lib', __FILE__

require 'muxoro/cli'
require 'daemons'

muxoro = Muxoro::CLI.new.init( ARGV[1..-1] )
reset_session = -> {
  muxoro.reset_sessions
}
 

Daemons.run_proc 'muxoro', stop_proc: reset_session do
  muxoro.run!
end
