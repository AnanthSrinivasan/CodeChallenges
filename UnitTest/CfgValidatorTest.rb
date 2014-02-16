require "../ConfigReader.rb"
require "../ConfigProcessor.rb"
require "../ConfigValidator.rb"

config = ConfigReader.instance
parser = ConfigProcessor.new(config)
unitHash, txnHash = parser.process

# Input is correct hence validation will go fine...
test = ConfigValidator.new
test.validate(unitHash, txnHash)

