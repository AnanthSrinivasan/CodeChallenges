require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require "../RequestValidator.rb"

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
parser.process
test = RequestValidator.new(parser)

input = "glob glob prok"
puts test.validateRequest input

input = "glob Silver prok"
puts test.validateRequest input
