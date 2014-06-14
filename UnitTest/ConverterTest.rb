require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require '../UnitConverter.rb'
require "../LanguageChecker.rb"

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
unitHash, txnHash = parser.process

test = UnitConverter.new()

langTest = LanguageChecker.new

input = 'IIII'

if langTest.roman? input
	puts test.romanToDec input
else
	puts 'Invalid Roman Language...'
end

input = 'III'

if langTest.roman? input
	puts test.romanToDec input
else
	puts 'Invalid Roman Language...'
end

input = 'XLII'

if langTest.roman? input
	puts test.to_decimal input
else
	puts 'Invalid Roman Language...'
end

input = 'X 1010'

require 'pry'
binding.pry

result = test.convert input, unitHash 

puts "result #{result}"