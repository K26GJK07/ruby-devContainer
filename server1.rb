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
  elsif path == "/api/now"
    s.print "HTTP/1.0 200 OK\r\n"
    s.print "Content-Type: application/json; charset=UTF-8\r\n"
    s.print "\r\n"
    s.puts "{"
    s.puts '"time": "' + "#{Time.now}" + '"'
    s.puts "}"
  else
    file = path.slice 1..-1
    if File.exist? file
      s.print "HTTP/1.0 200 OK\r\n"
      s.print "Content-Type: text/plain; charset=UTF-8\r\n"
      s.print "\r\n"
      File.open file, "r" do |f|
        while line = f.gets
          s.puts line
        end
      end
    else
      s.print "HTTP/1.0 404 Not Found\r\n"
      s.print "Content-Type: text/html; charset=UTF-8\r\n"
      s.print "\r\n" 
      s.puts "<h1>404 Not Found</h1>"      
      s.puts "<p> File: " + path + "</p>"
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
