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
		@cfgObject = Configobject.new
	end

	def fileContents filename
		File.open(filename) do |file|
			# get the range, blocked channels and channel sequence
			# and fills the configuration object
			file.each_with_index { |line, count|
				first, *rest = line.split(" ")
				if count == 0
					@cfgObject.lowestChannel = line.split(" ").first.to_i
					@cfgObject.highestChannel = line.split(" ").last.to_i
				end

				if count == 1
					@cfgObject.blockedChannelCount = first.to_i
					@cfgObject.blockedChannel = rest
					@cfgObject.blockedChannel.map! { |e| e.to_i } 
				end

				if count == 2
					@cfgObject.viewableChannelCount = first.to_i
					@cfgObject.navigationSequence = rest
					@cfgObject.navigationSequence.map! { |e| e.to_i }
				end
			}
		end
		@cfgObject
	end	
end

# contents = FileProcessor.instance.fileContents('../TextFiles/Input.txt')

# puts contents.lowestChannel.inspect
# puts contents.highestChannel.inspect
# puts contents.blockedChannel.inspect

# puts contents.navigationSequence.inspect
# puts contents.viewableChannelCount.inspect

