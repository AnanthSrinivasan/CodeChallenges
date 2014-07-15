require "time"
require_relative "./TalkSplitter.rb"

# Track Manager get the talks and sessions info from the organizer
# It arranges the talks info into the respective sessions
# It gives back the arranged tracks info to the Organizer.

class Track
	
	def init_members(talks_info, sessions_info)
		@talks_info = talks_info
		@contents = []
		@talks_to_delete = []
		@Output = Struct.new(:start, :talk, :duration)
	end
	
	def arrange(talks_info, sessions_info)
		init_members(talks_info, sessions_info)

		sessions_info.each { |session|
			add_session(session)
			if !@talks_to_delete.empty?
				@talks_to_delete.each { |talk| 
					@talks_info.delete_at(@talks_info.index(talk)) }
			end
			@talks_to_delete = []
		}
		@contents
	end

	def add_session(session)
		if session.type.split(" ")[0] == 'Lunch'
			arrange_talks(session.start, LUNCH, "")
		elsif session.type.split(" ")[0] == 'Networking'
			arrange_talks(session.start, NETWORKING, "")
		else
			insert_talks_to_session(session.start, session.duration.to_i)
		end
	end

	def insert_talks_to_session(session_start, duration)
		start = 0
		talk_splitter = TalkSplitter.new
		talks = talk_splitter.get_talks_for_duration(@talks_info, duration)
		talks.each_with_index do |talk, index|
			if start == 0
				start = session_start
			else
				start = compute_start(start, talks[index-1].duration)	
			end
			arrange_talks(start, talk.name, talk.duration)
			@talks_to_delete.push(talk)
		end
	end

	def arrange_talks(start, name, duration)
		@contents.push(@Output.new(start, name, duration))
	end

	def compute_start(start, duration)
		seconds = seconds_since_midnight(start) + duration.to_i * 60
		hour_minutes(seconds)
	end

	def seconds_since_midnight(time)
		Time.parse(time).hour * 3600 + Time.parse(time).min * 60 + Time.parse(time).sec
	end	

	def hour_minutes(seconds)
		Time.at(seconds).utc.strftime("%I:%M%p")
	end

	private :add_session, :insert_talks_to_session, :arrange_talks,
			:compute_start, :seconds_since_midnight, :hour_minutes
end
