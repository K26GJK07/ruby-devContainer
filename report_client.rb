#! /usr/local/bin/ruby

# ---------------------------------------------------------
#  <独自プロトコル>
#  バス乗降客数集計システムのサーバーとクライアント間での通信プロトコル
# 　
#  <設計方針 クライアント側>
#  ・csvデータから集計したバス乗降客数の結果を表示する
# ---------------------------------------------------------

require 'socket'

cmd = ARGV[0]
time_zone = ARGV[1]
host = ARGV[2]
port = ARGV[3]

if cmd == nil
  cmd = "ALL"
end

if host == nil
  host = 'localhost'
end

if port == nil
  port = 10000
end

sock = TCPSocket.new host, port

#------------------------------
# コマンド送信
#------------------------------

if time_zone == nil
  sock.puts cmd
else
  sock.puts "#{cmd} #{time_zone}"
end

sock.puts cmd

while line = sock.gets
  line = line.chomp
  line = line.force_encoding("UTF-8")  

  if line == "."
    break
  end

  hour, entry, exit, max_current_count, min_count = line.split ","
    puts "#{hour}時台: 乗車数 #{entry}人 降車数 #{exit}人 最大 #{max_current_count}人 最小 #{min_count}人"
end

sock.close
