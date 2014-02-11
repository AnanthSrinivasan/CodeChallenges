require "singleton"

# This class will serve as a adapter to read the input contents
# Currently we are reading the input from a file, we might read 
# the input from db as well. So the client who wants the config 
# should not worry where the input is read from 

# We only need a single instance of ConfigReader and we don't 
# want any other object in the system instantiate ConfigReader.
# Hence we will define this as a singleton class. 

class ConfigReader
	include Singleton
	
	def config
		file = File.read('../TextFiles/Input.txt')
	end	
end