#! /usr/local/bin/ruby

require 'socket'

host = 'www.is.kyusan-u.ac.jp'
port = 'http'
path = '/~toshi/ '
version = 'HTTP/1.1'

sock = TCPSocket.new host, port
#cmd = 'GET ' + path + version + "\r\n" + 'HOST: ' + host + "\r\n" + 'Connection: ' + 'close' + "\r\n\r\n"

#------------------------------
#別の書き方(文字列で書く)
#------------------------------
cmd = "GET #{path}#{version}\r\nHOST: #{host}\r\nConnection: close\r\n\r\n"
pp cmd
sock.print cmd

is_body = false

#------------------------------
#Ruby風 (条件分岐の書き方)
#------------------------------

while line = sock.gets
  puts line if is_body
  is_body = true if line == "\r\n"
end

#------------------------------
#一般的なアルゴリズム
#------------------------------
# while line = sock.gets
#   if is_body
#     puts line
#   end
#   if line == "\r\n"
#     is_body = true
#   end
# end