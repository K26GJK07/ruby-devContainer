#eval:evaluate（評価する）の略

#Rubyの場合、最後にevalした結果が返されるので”return”は不要
def max x, y
  if x>y
    x
  else
    y
  end
end
puts max 5, 10
puts max -3, -2

#Rubyはすべて実行してevalする
x = if 5 < 3
  "five"
else
  "three"
end
puts x