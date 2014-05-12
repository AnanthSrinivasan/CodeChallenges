require_relative "./configreader.rb"

require_relative "./configvalidator.rb"

# Configuration class is a cohesive unit which holds the config
# required for the system. 
# Steps:
# 1. Reads the configuration
# 2. Processes the configuration
# 3. Validates the configuration
# 4. Returns the fully baked configuration object 

class Configuration

	def initialize
		
	end
	
	def getConfig
		contents = FileProcessor.instance.fileContents
		
		# check all the constraints 
		validateConfig contents
	end



	def validateConfig contents
		cfgValidator = ConfigValidator.new (contents)
		cfgValidator.validate 
	end

	private :processConfig, :validateConfig

end
