
# Remote is the interface used by the user to play 
# channels in the stb/tv.

class Remote

	def initialize
		@stb = nil		
	end
	
	def pairUp stb
		@stb = stb
	end
	
	def pressButton button
		case button
			when '0'..'9'
				@stb.number button
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