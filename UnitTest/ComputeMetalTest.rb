require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require '../ComputeMetal.rb'

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
parser.process

test = ComputeMetal.new(parser)
silver, gold, iron = test.computeMetals

puts silver
puts gold
puts iron
