require '../ComputeMetal.rb'
require '../Configuration.rb'

config = Configuration.new
cfgObj = config.getConfig

txnHash = cfgObj.txnHash
unitHash = cfgObj.unitHash

test = ComputeMetal.new 
metalArray = test.computeMetals unitHash, txnHash

metalArray.each { |element| 
	puts "#{element.type} : #{element.value}"
}

