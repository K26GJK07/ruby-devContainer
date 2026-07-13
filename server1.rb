#! /usr/local/bin/ruby

require 'socket'

def server s
  cmd, path, ver = s.gets.split " "
  if path == "/"
    pp "INDEX"
    s.puts "index"
  else
    pp "OTHER"
    s.puts "other"
  end
  s.close
end

gs = TCPServer.open 'http'
loop do
  pp "start accept"
  s = gs.accept
  Thread.new do
    server s
  end
end
