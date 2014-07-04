require_relative "../lib/Track.rb"
require_relative "../lib/FileProcessor.rb"

describe Track do

	before :each do
		contents = FileProcessor.instance.file_contents('TextFiles/conference.txt')
		@track = Track.new(contents.talks_data, contents.sessions_data)
	end

	describe "#new" do
		it "returns the track object" do
			@track.should be_an_instance_of Track
		end
	end

end


# it should add sessions
# validate the session array count
