require_relative "./SkycastValidator.rb"

class SkycastSTB
	attr_accessor :defaultChannel
	attr_accessor :previousChannel
	attr_accessor :currentChannel

	# STB maintains default, previous and current channel state
	def initialize 
		@config = nil
		@defaultChannel = 0
		@previousChannel = 0
		@currentChannel = 0
	end

	# Once the stb object is created, client applies the configuraton
	# STB is setup with the given configuration and played upon
	def applyConfiguration configuration
		@config = configuration
		validator = SkycastValidator.new @config
		validator.validate

		@defaultChannel = @config.lowestChannel.to_i
		@previousChannel = @config.lowestChannel.to_i
		@currentChannel = @config.navigationSequence.first.to_i
	end

	def channelUp
		@previousChannel = @currentChannel
		if @currentChannel == @config.highestChannel
			@currentChannel = @config.lowestChannel
			# while rotating back ensure current channel is not in blocked list
			return if !@config.blockedChannel.include?@currentChannel
		end
		#loop until current channel rests for the non blocked channel
		loop do
			break if !@config.blockedChannel.include?(@currentChannel+=1)
		end
	end

	def channelDown
		@previousChannel = @currentChannel
		if @currentChannel == @config.lowestChannel 
			@currentChannel = @config.highestChannel
			return if !@config.blockedChannel.include?@currentChannel
		end
		loop do
			break if !@config.blockedChannel.include?(@currentChannel-=1)
		end
	end

	def channelBack
		swap(@currentChannel, @previousChannel)
	end

	def applyChannel

	end

	def swap currentChannel, previousChannel
		temp = currentChannel
		@currentChannel = previousChannel
		@previousChannel = temp
	end
end
