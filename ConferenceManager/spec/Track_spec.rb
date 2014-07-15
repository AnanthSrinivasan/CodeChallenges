require_relative "../lib/Track.rb"
require_relative "../lib/FileProcessor.rb"

describe Track do

	before :each do
		@config = FileProcessor.instance.file_contents('TextFiles/conference.txt')
		@track = Track.new
	end

	describe "#new" do
		it "returns the track object" do
			@track.should be_an_instance_of Track
		end
	end

	describe "#arrange" do
		it "should take talks info and sessions info and return contents" do
			contents = @track.arrange(@config.talks_data, @config.sessions_data) 
			contents.size.should eql(12) 
		end
	end

end

