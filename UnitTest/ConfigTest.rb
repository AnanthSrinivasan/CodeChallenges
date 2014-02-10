require '../ConfigProcessor.rb'
require '../ConfigReader.rb'

test = ConfigProcessor.new(ConfigReader.instance)
test.process

if test.units.empty? 
	puts 'No Units...Wrong Configuration'
else
	puts test.units
end

if test.transactions.empty? 
	puts 'No Transaction measure...Cannot compute'
else
	puts test.transactions
end
