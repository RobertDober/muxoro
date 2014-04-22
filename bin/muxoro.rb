#!/usr/bin/env ruby

$:.unshift File.expand_path '../../lib', __FILE__

require 'muxoro/cli'
require 'daemons'

Daemons.run_proc 'muxoro' do
  Muxoro::CLI.new.run ARGV[1..-1]
end
