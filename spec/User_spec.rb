require_relative "../lib/User.rb"

describe User do

	before :each do
		@user = User.new
	end

	describe "#new" do
		it "returns the user object" do
			@user.should be_an_instance_of User
		end
	end

	describe "#navigateSequence" do
		it "returns the minimum clicks for the sequence given in the configuration" do
			@user.navigateSequence('TextFiles/Input.txt')
			
		end
	end
	
end