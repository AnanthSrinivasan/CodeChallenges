require_relative "./SkycastValidator.rb"

class SkycastSTB
	attr_accessor :defaultChannel
	attr_accessor :previousChannel
	attr_accessor :currentChannel

	def initialize 
		@config = nil
		@defaultChannel = 0
		@previousChannel = 0
		@currentChannel = 0
	end

	def applyConfiguration configuration
		@config = configuration
		validator = SkycastValidator.new @config

		@defaultChannel = @config.lowestChannel.to_i
		@previousChannel = @config.lowestChannel.to_i
		@currentChannel = @config.navigationSequence.first.to_i
	end

end
