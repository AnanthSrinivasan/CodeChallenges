ab = "180,9am,Morning session"
puts ab.split(',')[0]
puts ab.split(',')[1]
# puts ab.split(',')[2]

Session = Struct.new(:duration, :start, :type)
session_array = []
session_array.push(Session.new(20,9,'morning'))
session_array.push(Session.new(30,1,'afternoon'))

session_array.each { |str| 
	puts str
}

val = "30min"
puts val.split('min')[0] if val.include? 'min'