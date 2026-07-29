#! /usr/local/bin/ruby

# ---------------------------------------------------------
#  <独自プロトコル>
#  バス乗降客数集計システムのサーバーとクライアント間での通信プロトコル
# 　
#  <設計方針 サーバー側>
#  ・現在研究で出力されるデータcount_log.csvを解析 -> 時間帯ごとの乗降客数を集計
#  ・csvデータなので、必要なデータを抽出 -> timestamp・action・current_count
#  ・timestamp -> 時間帯ごとに分類
#  ・action -> 乗車数・降車数を算出
#  ・current_count -> その時間帯の最大車内人数を算出
# ---------------------------------------------------------

require 'socket'

path = 'count_log.csv'

entry_count = Array.new(24, 0)
exit_count = Array.new(24, 0)
max_current_count = Array.new(24, 0)

File.open path, "r" do |f|
  while line = f.gets
    line = line.chomp
    if line.start_with?("timestamp")
      next
    end
    timestamp, action, id, current_count = line.split ","

    date, time = timestamp.split " "
    #デバッグ用
    #p [date, time, action, current_count]

    hour = time[0, 2].to_i
    if action == "Entry"
      entry_count[hour] += 1
    elsif action == "Exit"
      exit_count[hour] += 1
    end

    if current_count.to_i > max_current_count[hour]
      max_current_count[hour] = current_count.to_i
    end
  end
end

# (10..17).each do |hour|
#   puts "#{hour}時台: 乗車数 #{entry_count[hour]}人 降車数 #{exit_count[hour]}人"
# end

gs = TCPServer.open 10000
loop do
  pp "start accept"
  s = gs.accept

  (10..17).each do |hour|
    s.puts "#{hour},#{entry_count[hour]},#{exit_count[hour]},#{max_current_count[hour]}"
  end

  s.close
end


