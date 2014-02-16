require '../ComputeMetal.rb'
require '../Configuration.rb'

config = Configuration.new
cfgObj = config.getConfig

txnHash = cfgObj.txnHash
unitHash = cfgObj.unitHash

test = ComputeMetal.new 
metalObj = test.computeMetals unitHash, txnHash

puts metalObj.silver
puts metalObj.gold
puts metalObj.iron
