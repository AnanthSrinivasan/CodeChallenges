require_relative "../lib/Session.rb"
require_relative "../lib/TalkObject.rb"

describe Session do
	
	before :each do
		@session = Session.new
		@talk = TalkObject.new
	end

	describe "#new" do
		it "returns the Session object" do
			@session.should be_an_instance_of Session
		end
	end

	describe "#add_talks" do
		it "adds the talk object to the session" do
			@talk1 = TalkObject.new
			@talk.name = "Writing Fast Tests Against Enterprise Rails"
			@talk.duration = "60min" 
			@talk2 = TalkObject.new
			@talk2.name = "Common Ruby Errors"
			@talk2.duration = "45min" 
			
			@session.add_talk(@talk1)
			@session.add_talk(@talk2)
			@session.talks.size.should eql(2)
		end
	end

	describe "#full?" do
		it "should check "

	end

end

# it should add talks
# validate the minutes based on the session type
