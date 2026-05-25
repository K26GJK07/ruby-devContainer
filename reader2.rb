# ------------------------------------------------
# f.closeの代用
# ------------------------------------------------

File.open "reader2", "r" do |f|
  while line = f.gets
    puts line
  end
end