require_relative "../lib/User.rb"

describe User do

	before :each do
		@user = User.new
		@user.setupTV('../TextFiles/Input.txt')
	end

	describe "#new" do
		it "returns the user object" do
			@user.should be_an_instance_of User
		end
	end

	describe "#navigateSequence" do
		it "returns the minimum clicks for the sequence given in the configuration" do
			response = @user.navigateSequence('TextFiles/Input.txt')
			response.clicks.should eql(12)
			response.status.should eql(Status::SUCCESS)
		end

		it "returns the minimum clicks for the sequence given in the configuration" do
			response = @user.navigateSequence('TextFiles/Input.txt')
			response.status.should eql(Status::FAILURE)
		end

	end
	
end