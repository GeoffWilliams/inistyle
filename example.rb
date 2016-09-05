require './lib/inistyle'
inistyle = IniStyle.new("my.ini")
puts inistyle.sections
puts "still here"
puts inistyle['masters']
