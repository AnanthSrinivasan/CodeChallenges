require '../ConfigProcessor.rb'
require '../ConfigReader.rb'

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
unitHash, txnHash = parser.process

if unitHash.empty? 
	puts 'No Units...Wrong Configuration'
else
	puts unitHash
end

if txnHash.empty? 
	puts 'No Transaction measure...Cannot compute'
else
	puts txnHash
end
