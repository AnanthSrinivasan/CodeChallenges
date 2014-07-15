require_relative "./FileProcessor.rb"
require_relative "./TalkSplitter.rb"
require_relative "./Track.rb"
require_relative "./Response.rb"

# Organizer reads the config and splits the talks per day
# Hands off the per day information to Track Manager to arrange talks

class Organizer
	def initialize
		@Talk = Struct.new(:name, :duration)
	end

	def organize_talks(filename)
		begin
			response = Response.new
			config = FileProcessor.instance.file_contents(filename)
			talk_duration_per_day = duration(config.sessions_data)
			tracks = split_talks(config, talk_duration_per_day)
		rescue Exception => e
			response.status = Status::FAILURE
			response.err_msg = e.message
			return response
		else
			response.status = Status::SUCCESS
			response.err_msg = "Talks are organized..."
			response.tracks_array = tracks
			return response
		end
	end	

	def duration(sessions_data)
		mins = 0
		sessions_data.each do |session| 
			if (session.type.split(" ")[0] == 'Morning' ||
				session.type.split(" ")[0] == 'Afternoon')
				mins += session.duration.to_i
			end
		end
		mins
	end	
	
	def split_talks(config, talk_duration_per_day)
		tracks = []
		while !config.talks_data.empty?
			talks_info = []
			# Take the talk information till we hit the duration per day
			talk_splitter = TalkSplitter.new
			talks = talk_splitter.get_talks_for_duration(config.talks_data, talk_duration_per_day)

			# Store the talk information required for one day 
			# and remove from the original config data
			talks.each do |talk| 
				talks_info.push(talk)
				config.talks_data.delete_at(config.talks_data.index(talk)) 
			end
			# Call Track Manager to arrange the talk information for that day
			track = Track.new
			tracks.push(track.arrange(talks_info, config.sessions_data))
		end
		return tracks
	end

	private :split_talks, :duration
end
