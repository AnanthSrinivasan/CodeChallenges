array = [15, 14, 17, 1, 17, 18]

array.each_with_index do |element,index|
	puts "#{array[index]}, #{array[index+1]}"	
	puts index	
	break if index == array.size-2
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


# low = 10 
# high = 20

# if(high >= low)
# 	puts "high greater"
# end

# blockedChannel = ["18", "19", "15"]
# navseq = ["15", "14", "17", "1", "20"]

# puts "common : #{blockedChannel & navseq}"
# if !(blockedChannel & navseq).empty?
# 	puts "common present"
# else
# 	puts "no "

# end

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


#puts 12345.to_s.size

# a = 10
# b = 20
# c = 5

# puts [a, b, c].index([a, b, c].min)

# a = ["18", "19"]
# a.map! { |e| e.to_i }
# puts a.inspect

# range = 107..104

# 107.downto(104).each { |e| puts e }

#(1...8).reverse.each { |x| puts x }



class Foo

  def initialize(num)
    raise ArgumentError.new("Not valid number") if num > 1000
    @num = num
  end 

end

begin

f = Foo.new(4000) #=> n `initialize': not valid (RuntimeError)

rescue ArgumentError => e

	puts e.message

end

# class Person
# 	attr_accessor :name
#   def initialize(name)
#     raise ArgumentError, "No name present" if name.empty?
#     @name = name
#   end

# end

# fred = Person.new("")
# puts "Name is #{fred.name}"

#for(current++ != blocked);

blockedChannel = ["18", "20", "15"]
blockedChannel.map! {|e| e.to_i}
current = 17
loop do
	current+=1
	break if !blockedChannel.include?(current)
end

#puts current
# loop do
# 	break if 
# end
prev = 98
curr = 77
seq = [10, 13, 13, 100, 99, 98, 77, 81]
#seq = [1, 100, 1, 101]
# index = seq.rindex{|x| x == 100 }
# puts index
# puts seq[index+1]
seq.unshift(1)
puts seq.inspect
nextVal = 0
seq.each_with_index do |element, index|
	puts seq[index]
	puts seq[index+1]
	# if (seq[index] == prev &&
	#     seq[index+1] == curr)
	# 	nextVal = seq[index+2]
	# end
	break if index == seq.size-2
end
puts "next #{nextVal}"


2.times do
	puts 'hi'
end

# number = 123

# 123-100 = 23
# 23-10 = 3

# 123
# 123/10=12 - 10
# 12/10=1 - 100
# 1/10=0 - 1000

# 1000/10 = 100
# 123/100 = 1
# 123%100 = 23

# 100/10 = 10
# 23/10 = 2
# 23%10 = 3

# 10/10 = 1
# 3/1 = 3
# 3%1 = 0

1234.to_s.chars.map(&:to_i).each {|e| puts e}
