# It holds the data required by the domain in order to 
# validate against the input request

# rangeHash - Range of channels in the tv
# blockedChannelCount - Number of channels blocked
# blockedChannel - Array of blocked channels 
# viewableChannelCount - Number of channels viewable
# navigationSequence - Array of channels to navigate

class ConfigObject
	attr_accessor :rangeHash
	attr_accessor :blockedChannelCount
	attr_accessor :blockedChannel
	attr_accessor :viewableChannelCount
	attr_accessor :navigationSequence

end