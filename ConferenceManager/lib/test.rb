ab = "180,9am,Morning session"
puts ab.split(',')[0]
puts ab.split(',')[1]
# puts ab.split(',')[2]

Session = Struct.new(:duration, :start, :type)
session_array = []
session_array.push(Session.new(20,9,'morning session'))
session_array.push(Session.new(30,1,'afternoon session'))
session_array.push(Session.new(30,12,'lunch session'))

mins = 0
session_array.each { |str| 
	if (str.type.split(" ")[0] == 'morning' ||
		str.type.split(" ")[0] == 'afternoon' )
		mins += str.duration.to_i
	end
}
puts mins


puts (Time.local(1,1,1) + 82400).strftime("%I:%M%p")


def hour_minutes(seconds)
  puts Time.at(seconds).utc.strftime("%I:%M%p")
end

hour_minutes(86400)

require 'time'

def seconds_since_midnight(time)
  Time.parse(time).hour * 3600 + Time.parse(time).min * 60 + Time.parse(time).sec
end

puts seconds_since_midnight("12:00AM")

val = "30min"
puts val.split('min')[0] if val.include? 'min'

puts value
last_val = 0
if val.include?('min')
	last_val = val.split('min')[0].to_i 
else
	last_val = 5
end

