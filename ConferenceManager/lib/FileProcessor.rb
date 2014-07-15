require "singleton"
require_relative "./ConfigObject.rb"
require_relative "./Constants.rb"

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
		@Session = Struct.new(:duration, :start, :type)
		@Talk = Struct.new(:name, :duration)
	end

	def file_contents(filename)
		cfgObject = ConfigObject.new
		events = []
		sessions = []
		
		File.open(filename) do |file|
			file.each do |line|
				if line[/(session)/].nil?
					key, value = line.reverse.split(" ", 2).map(&:reverse).reverse
					if value.include?('min') || value.include?('lightning')
						value = value.include?('min') ? value.split('min')[0].to_i : LIGHTNING
						events.push(@Talk.new(key, value))
					else
						raise StandardError, "Value is nil"
					end
				else
					data = line.split('|')
					sessions.push(@Session.new(data[0], data[1], data[2]))
				end				
			end
		end
		cfgObject.talks_data =  events
		cfgObject.sessions_data = sessions
		cfgObject
	end		
end

