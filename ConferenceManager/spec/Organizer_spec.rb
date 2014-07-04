require_relative "../lib/Organizer.rb"

describe Organizer do

	before :each do
		@org = Organizer.new
	end

	describe "#new" do
		it "returns the Organizer object" do
			@org.should be_an_instance_of Organizer
		end
	end

	describe "#organize_talks" do
		it ""

	end



end
