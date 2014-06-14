require '../Configuration.rb'

test = Configuration.new
@cfg = test.getConfig

puts @cfg.txnHash
puts @cfg.unitHash
puts @cfg.vocabulary

@cfg.metalObject.each { |element| 
	puts "#{element.type} : #{element.value}"
}


# puts @cfg.metalObject.silver
# puts @cfg.metalObject.gold
# puts @cfg.metalObject.iron
