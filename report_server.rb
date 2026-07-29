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

File.open path, "r" do |f|
  while line = f.gets
    line = line.chomp
    if line.start_with?("timestamp")
      next
    end
    timestamp, action, id, current_count = line.split ","
    p [timestamp, action, current_count]
  end
end