#! /usr/local/bin/ruby

# ---------------------------------------------------------
#  <独自プロトコル>
#  バス乗降客数集計システムのサーバーとクライアント間での通信プロトコル
# 　
#  <設計方針 クライアント側>
#  ・csvデータから集計したバス乗降客数の結果を表示する
# ---------------------------------------------------------

require 'socket'

host = ARGV[0]
port = ARGV[1]

if host == nil
  host = 'localhost'
end

if port == nil
  port = 10000
end

sock = TCPSocket.new host, port

while line = sock.gets
  line = line.chomp
  line = line.force_encoding("UTF-8")  
  hour, entry, exit, max_current_count, min_count = line.split ","
  puts "#{hour}時台: 乗車数 #{entry}人 降車数 #{exit}人 最大 #{max_current_count}人 最小 #{min_count}人"
end

sock.close
