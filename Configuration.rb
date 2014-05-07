require_relative "./ConfigReader.rb"
require_relative "./ConfigObject.rb"
require_relative "./ConfigValidator.rb"

# Configuration class is a cohesive unit which holds the config
# required for the system. 
# Steps:
# 1. Reads the configuration
# 2. Validates the configuration
# 3. Processes the configuration
# 4. Returns the fully baked configuration object 

class Configuration

	def initialize()
		@rangeHash = {}
		@blockedChannelCount = 0
		@blockedChannel = []
		@viewableChannelCount = 0
		@navigationSequence = []
		@configObject = ConfigObject.new
	end
	
	def getConfig
		config = ConfigReader.instance.config

		# compute the range, blocked channels and channel sequence
		processConfig config

		constructObject

		# checks for all the constraints before returning the object
		validateConfig

		return @configObject
	end

	def processConfig config
		config.each_with_index { |line, count|
			first, *rest = line.split(" ")

			if count == 0
				@rangeHash[:low] = line.split(" ").first
				@rangeHash[:high] = line.split(" ").last
			end

			if count == 1
				@blockedChannelCount = first.to_i
				@blockedChannel = rest
			end

			if count == 2
				@viewableChannelCount = first.to_i
				@navigationSequence = rest
			end
		}
	end

	def validateConfig 
		cfgValidator = ConfigValidator.new
		cfgValidator.validate @configObject
	end

	def constructObject 
		@configObject.rangeHash 			= @rangeHash
		@configObject.blockedChannelCount 	= @blockedChannelCount
		@configObject.blockedChannel 		= @blockedChannel
		@configObject.viewableChannelCount 	= @viewableChannelCount
		@configObject.navigationSequence 	= @navigationSequence
	end

	private :processConfig, :validateConfig, :constructObject

end