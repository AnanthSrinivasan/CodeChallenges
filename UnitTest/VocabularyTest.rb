require '../Vocabulary.rb'
require '../Configuration.rb'

config = Configuration.new
cfgObj = config.getConfig

txnHash = cfgObj.txnHash
unitHash = cfgObj.unitHash

test = Vocabulary.new
puts test.buildVocabulary(unitHash, txnHash)



