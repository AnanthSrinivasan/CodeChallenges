require_relative "./Organizer.rb"
require_relative "./Response.rb"
require_relative "./Constants.rb"

# Initialize response objects
response = Response.new
response.status = Status::FAILURE

organizer = Organizer.new
response = organizer.organize_talks('../TextFiles/conference.txt')

if response.status == "success"
	puts "Status : #{response.status}"
	puts "Reason : #{response.err_msg}"
	puts "Track Information"
	response.tracks_array.each_with_index do |tracks, index|
		puts "Track : #{index+1}"
		tracks.each do |track|
			track.duration = (track.duration == LIGHTNING) ? 'lightning' : 
				!(track.talk == LUNCH || track.talk == NETWORKING) ? track.duration.to_s + 'min' : ""
		puts "#{track.start} #{track.talk} #{track.duration}"
		end
		puts "================================================"
	end
end	
