# It holds the data required by the domain in order to 
# validate against the input request

# lowestChannel - lowest channel in the tv
# highestChannel - highest channel in the tv
# blockedChannelCount - Number of channels blocked
# blockedChannel - Array of blocked channels 
# viewableChannelCount - Number of channels viewable
# navigationSequence - Array of channels to navigate

class Configobject
	attr_accessor :lowestChannel
	attr_accessor :highestChannel
	attr_accessor :blockedChannelCount
	attr_accessor :blockedChannel
	attr_accessor :viewableChannelCount
	attr_accessor :navigationSequence

	def initialize
		
	end
end