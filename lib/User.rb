require_relative "./FileProcessor.rb"
require_relative "./ValidationError.rb"
require_relative "./SkycastValidator.rb"

# Configuration class is a cohesive unit which holds the config
# required for the system. 
# Steps:
# 1. Load the configuration from the file
# 2. Apply the configuration to the SkycastSTB
# 3. Navigate the sequence

class User

	def initialize
		
	end
	
	def navigateSequence
		begin
			config = FileProcessor.instance.fileContents
		#-TODO-
			stb = STB.new
			stb.applyConfig config
			# apply configuration into setup box

			# let the stb validates the constraints and throw error if any
			# validateConfig contents has to be done in SkycastSTB object. 

			# catch it and display back to the client 

			# Navigate the sequence

		rescue ValidationError => e 
			
		end
	end


end


user = User.new
user.navigateSequence