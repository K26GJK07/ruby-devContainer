# リテラル 数値リテラル、文字列リテラル、配列リテラル
# 例. Javaで表現
# int x = 5; → 数値リテラル
# String s = "KSU" → 文字列リテラル
# long y = 5L → 数値リテラル
# int [] a = new int[2]
# int[] a = {1,3,5}　→　配列リテラル❌
# Javaでは配列リテラルはできない
# 

# ------------------------------------------------
# Java風のRuby言語の配列
# ------------------------------------------------

ia = [1, 3, 5]
sa = Array.new
sa[0] = "Java"
sa[1] = "Ruby"
sa[2] = "C++"
i = 0
while i<ia.length
  print ia[i].to_s+","
  i+=1
end
puts

# ------------------------------------------------
# 配列
# Rubyの配列には型無関係になんでも入れることができる
# ------------------------------------------------

ia.each do |i|
  print i.to_s + ","
end
puts

xa = [1, 3.5, "Ruby", 5, [3,5]]
xa.each_with_index do |i, idx|
  p [i, idx]
end

z = [3, 5, 10 ,7, 2, -2]
zs = z.sort
p z
p zs
