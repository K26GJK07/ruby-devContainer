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
#  ・max_count -> その時間帯のcurrent_countの最大値を算出
#  ・min_count -> その時間帯のcurrent_countの最小値を算出
#   ---------------------------------------------------------

require 'socket'

#------------------------------
# CSVデータの解析
#------------------------------

def load_csv path

entry_count = Array.new(24, 0)
exit_count = Array.new(24, 0)
max_count = Array.new(24, 0)
min_count = Array.new(24, nil)
max_hour = nil
min_hour = nil

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

      if current_count.to_i > max_count[hour]
        max_count[hour] = current_count.to_i
      end

      if min_count[hour] == nil || current_count.to_i < min_count[hour]
        min_count[hour] = current_count.to_i
      end

      if max_hour == nil || hour > max_hour
        max_hour = hour
      end

      if min_hour == nil || hour < min_hour
        min_hour = hour
      end

    end
  end

  return entry_count, exit_count, max_count, min_count, max_hour, min_hour
end

#------------------------------
# CSVデータの集計
#------------------------------

def server s, entry_count, exit_count, max_count, min_count, max_hour, min_hour

  while line = s.gets
    cmd, time_zone = line.chomp.split " "
    pp cmd

    if cmd == "ALL"
      (min_hour..max_hour).each do |hour|
        s.puts "#{hour},#{entry_count[hour]},#{exit_count[hour]},#{max_count[hour]},#{min_count[hour]}"
      end
       s.puts "."
    elsif cmd == "HOUR"
      if time_zone == nil
        s.puts "ERROR"
      else
        hour = time_zone.to_i
        if hour < min_hour || hour > max_hour
          s.puts "ERROR_no_data"
        else
          hour = time_zone.to_i
          s.puts "#{hour},#{entry_count[hour]},#{exit_count[hour]},#{max_count[hour]},#{min_count[hour]}"
        end
      end
      s.puts "."
    elsif cmd == "QUIT"
      break
    else
      s.puts "ERROR_unknown_command"
      s.puts "."
    end
  end
  s.close
end

entry_count, exit_count, max_count, min_count, max_hour, min_hour = load_csv 'count_log.csv'

gs = TCPServer.open 10000
loop do
  pp "start accept"
  s = gs.accept
  server s, entry_count, exit_count, max_count, min_count, max_hour, min_hour
end