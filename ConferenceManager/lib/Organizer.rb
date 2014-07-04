

class Organizer
	def initialize

	end

	def organize_talks(filename)
		@config = FileProcessor.instance.file_contents(filename)
		
		@config.talks_data
		@config.sessions_data
		
		@config.talks_hash.each_pair do |key, val|  
			talk = TalkObject.new
			talk.name = key
			talk.duration = val
			
			build_session(talk)

		end
	end	

	def build_session(talk)
		session = Session.new
		session.add_talk(talk)

	end
	
end
