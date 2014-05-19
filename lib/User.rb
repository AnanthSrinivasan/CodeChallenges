require_relative "./FileProcessor.rb"
require_relative "./ValidationError.rb"
require_relative "./SkycastValidator.rb"

# User is the orchestrator who wants to navigate through the
# given sequence as mentioned in the configuration

# Steps:
# 1. Load the configuration from the file
# 2. Apply the configuration to the SkycastSTB
# 3. Pairs up the remote with the stb
# 4. Identifies minimum steps required to navigate
#	 step by step to complete the sequence
# 5. Uses the remote object to follow the action
#	 which would help navigate through minimum steps

class User

	def initialize
		
	end
	
	def navigateSequence
		begin
			# loads up the configuration from file
			config = FileProcessor.instance.fileContents('TextFiles/Input.txt')
		
			# boot up stb and apply configuration into it
			stb = STB.new
			stb.applyConfig config

			# pair up the remote object with the stb
			remote = remote.new
			remote.pairUp stb

			# Navigate the sequence

		rescue ValidationError => e 

		rescue ArgumentError => e

		end
	end


end


user = User.new
user.navigateSequence