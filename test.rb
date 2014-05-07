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