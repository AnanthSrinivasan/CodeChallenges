# Remote is the interface used by the user to play 
# channels in the stb/tv.
class Remote

	def initialize
		@stb = nil		
	end
	
	# Remote object has to be created and paired up with STB
	def pairUp stb
		@stb = stb
	end
	
	# Based on the input to the remote corresponding action 
	# on the tv will be performed
	def pressButton button
		case button
			when '0'..'9'
				@stb.channelNumber button
			when 'u'
				@stb.channelUp
			when 'd'
				@stb.channelDown
			when 'b'
				@stb.channelBack
			else
				raise ValidationError.new(SkycastValidator, 
					ErrorMsg::INVALID_INPUT_TO_REMOTE) 
		end
	end
end