#! /usr/local/bin/ruby

require 'socket'

gs = TCPServer.open 'http'
s = gs.accept

loop do
  pp "start accept"
  s = gs.accept
  while line = s.gets
    pp line
    s.puts line
    break if line == "\r\n"
  end
s.close
sleep 10
end
