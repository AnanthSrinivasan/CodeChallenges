class TalkSplitter
	def initialize
		
	end

	def get_talks_for_duration(talks_info, duration)
		value = 0
		talks = []
		# Talk the talk information till we hit the duration per day
		talks_info.each do |talk|  
			value += talk.duration
			value <= duration ? talks.push(talk) : break
		end
		talks
	end

end
