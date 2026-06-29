#! /usr/local/bin/ruby

require 'socket'

def server s
  while line = s.gets
    pp line
    s.puts line
    break if line == "\r\n"
  end
  s.close
end

gs = TCPServer.open 'http'
loop do
  pp "start accept"
  s = gs.accept
  server s
  sleep 10
end
