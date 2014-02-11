require '../ConfigProcessor.rb'
require '../ConfigReader.rb'
require '../Vocabulary.rb'

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
parser.process

test = Vocabulary.new(parser)
test.build

code = "glob glob prok"
code.chomp.split(" ").each { |e| 
	puts 'not present...' unless test.find e
}

code = "glob glob test"
code.chomp.split(" ").each { |e| 
	puts 'not present...' unless test.find e
}


