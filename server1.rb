#! /usr/local/bin/ruby

require 'socket'

def server s
  cmd, path, ver = s.gets.split " "
  # HTTP/1.0 として正しく返答
  # 1行目 HTTP/1.0 200 OK
  # 2行目 Content-Type: text/html
  # 3行目 空行
  # 4行目 コンテンツ
  # 最後 ソケットをクローズ

  if path == "/"
    s.print "HTTP/1.0 200 OK\r\n"
    s.print "Content-Type: text/html\r\n"
    s.print "\r\n"
    pp "INDEX"
    s.puts "<h1>index</h1>"
  else
    file = path.slice 1..-1
    File.open file, "r" do |f|
      while line = f.gets
        s.puts line
      end
    end      
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
