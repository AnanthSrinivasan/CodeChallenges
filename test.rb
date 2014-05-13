array = [15, 14, 17, 1, 17]

array.each_with_index do |element,index|
	puts "#{array[index]}, #{array[index+1]}"		
end

a = ['sda', 'sdb', 'sdc', 'sdd', 'dds']
a.each_slice(2) do |b|
    p b
end


File.open("TextFiles/Input.txt").each_with_index { |line, count|
    puts "#{count} > #{line}"
}

def is_numeric(o)
    true if Integer(o) rescue false
end

# blockedChannel.each { |val| 
# 	puts val
# 	puts is_numeric val
# }

#puts !(12.is_a? Fixnum)


# if val.to_i <= 0
# 	puts val
# else
# 	puts 'error'
# end

# puts 10000.to_s.inspect
	def number?(o)
	    true if Integer(o) rescue false
	end


File.open('TextFiles/Input.txt') do |file|
	# get the range, blocked channels and channel sequence
	# and fills the configuration object
	file.each_with_index { |line, count|
		if count == 0
			# range[:low] = line.split(" ").first
			# range[:high] = line.split(" ").last
			# @cfgObject.rangeHash = range
			puts number? line.split(" ").first
			puts number? line.split(" ").last
		end
	}

end


low = 10 
high = 20

if(high >= low)
	puts "high greater"
end

blockedChannel = ["18", "19", "15"]
navseq = ["12", "14", "17", "1", "20"]

puts "common : #{blockedChannel & navseq}"
if !(blockedChannel & navseq).empty?
	puts "common present"
else
	puts "no "

end

# if(blockedChannel.uniq.sort == navseq.uniq.sort)
# blockedChannel.each { |val| 
# 	navseq.each { |v|
# 		if val == v
# 			puts "common present"
# 			break
# 		end
# 	}
# }

#puts blocked

#to find union
#(a-b) | (b-a)