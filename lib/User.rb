require_relative "./FileProcessor.rb"

require_relative "./SkycastValidator.rb"

# Configuration class is a cohesive unit which holds the config
# required for the system. 
# Steps:
# 1. Gets the file contents
# 2. Validates the contents


class User

	def initialize
		
	end
	
	def navigateSequence
		begin
			contents = FileProcessor.instance.fileContents
		
			# check all the constraints 
			validateConfig contents
		rescue ValidationError => e 
			
		end
	end



	def validateConfig contents
		cfgValidator = SkycastValidator.new (contents)
		cfgValidator.validate 
	end

	private :validateConfig

end


user = User.new
user.navigateSequence