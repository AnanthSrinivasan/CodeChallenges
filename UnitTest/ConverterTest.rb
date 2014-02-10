require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require '../UnitConverter.rb'
require "../LanguageChecker.rb"

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
parser.process

test = UnitConverter.new(parser)

#puts test.unitToRoman "glob glob Silver"

langTest = LanguageChecker.new

input = 'III'

if langTest.roman? input
	puts test.romanToDec input
else
	puts 'Invalid Roman Language...'
end
