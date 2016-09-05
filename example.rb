require './lib/inistyle'
inistyle = Inistyle.new("my.ini")
puts inistyle.sections
puts "still here"
puts inistyle['masters']
