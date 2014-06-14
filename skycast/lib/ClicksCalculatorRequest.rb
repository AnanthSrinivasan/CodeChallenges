# ClicksCalculator provides the minimum clicks it takes
# to reach from source to target

# source - source element in the given request
# target - target element in the given request
# lowestChannel - lowest channel in the tv
# highestChannel - highest channel in the tv
# blockedChannel - Array of blocked channels 

class ClicksCalculatorRequest
	attr_accessor :source
	attr_accessor :target
	attr_accessor :blockedChannel
	attr_accessor :lowestChannel
	attr_accessor :highestChannel

	def initialize
		
	end
end