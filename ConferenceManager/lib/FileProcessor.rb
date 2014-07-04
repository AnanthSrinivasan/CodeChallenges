require "singleton"
require_relative "./ConfigObject.rb"

# This class will serve as a adapter to read the file contents
# Currently we are reading the input from a file, we might read 
# the input from db as well. So the client who wants the config 
# should not worry where the input is read from. Output is given
# in the form of a filled config object 

# We only need a single instance of FileProcessor and we don't 
# want any other object in the system instantiate FileProcessor.
# Hence we will define this as a singleton class. 

class FileProcessor
	include Singleton
	
	def initialize
		@cfgObject = ConfigObject.new
		@Session = Struct.new(:duration, :start, :type)
	end

	def file_contents(filename)
		events_hash = {}
		sessions_array = []
		
		File.open(filename) do |file|
			file.each do |line|
				if line[/(session)/].nil?
					key, value = line.reverse.split(" ", 2).map(&:reverse).reverse
					events_hash[key] = value
				else
					data = line.split('|')
					sessions_array.push(@Session.new(data[0], data[1], data[2]))
				end				
			end
		end
		@cfgObject.talks_data =  events_hash
		@cfgObject.sessions_data = sessions_array
		@cfgObject
	end	
end

# contents = FileProcessor.instance.file_contents('../TextFiles/conference.txt')
# puts contents.talks_data
# puts contents.sessions_data


