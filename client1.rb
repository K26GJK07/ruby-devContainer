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
puts line