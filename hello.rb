#! /usr/bin/env ruby

puts "Hello, World!"

# 変数の型は？ → 変数宣言が不要
a=-5
s="Ruby"
d=3.14
# puts "a:" + a ❌　→ Java言語のように"+"の前後の変数で加算か連結を判断するわけでない
puts "a:" + a.to_s()
puts s
puts "d:" + d.to_s()
# ⭐️キーワード⭐️ 原始型(Java)、オブジェクト(Ruby)

if a > 5
  puts "Large"
elsif a < 0
  puts "Negative"
else
  puts "Little"
end

x = 5
while x > 0
    print "#"
    x-=1
end 
puts

5.times do |i|
  print i.to_s + ","
end
puts