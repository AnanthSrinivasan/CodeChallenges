require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require '../ComputeMetal.rb'

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
parser.process

test = ComputeMetal.new(parser)
test.buildMetalHash
test.segregateMetals

puts test.silver
puts test.gold
puts test.iron
