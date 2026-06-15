#! /usr/local/bin/ruby

require 'socket'

host = 'www.is.kyusan-u.ac.jp'
port = 'http'
path = '/~toshi/'

sock = TCPSocket.new host, port
cmd = 'GET ' + path + "\r\n"
pp cmd
sock.print cmd

line = sock.gets

#-----------------------------
#一行だけ表示
#-----------------------------

#puts line

#-----------------------------
#複数行表示(全部)
#-----------------------------
while line = sock.gets
  puts line
end