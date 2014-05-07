require '../Configuration.rb'

test = Configuration.new
@cfg = test.getConfig

puts @cfg.rangeHash
puts @cfg.blockedChannelCount
puts @cfg.blockedChannel.inspect
puts @cfg.viewableChannelCount
puts @cfg.navigationSequence.inspect

