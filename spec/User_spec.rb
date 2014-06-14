require_relative "../lib/User.rb"

describe User do

	before :each do
		@user = User.new
		@user.setupTV('TextFiles/Input.txt')
	end

	describe "#new" do
		it "returns the user object" do
			@user.should be_an_instance_of User
		end
	end

	describe "#navigateSequence" do
		it "returns the minimum clicks for the sequence given in the configuration" do
			@user.setupTV('TextFiles/TestInput.txt')
			navResponse = @user.navigateSequence
			navResponse.clicks.should eql(7)
			navResponse.status.should eql(Status::SUCCESS)
		end

		it "returns the minimum clicks for the sequence given in the configuration" do
			response = @user.setupTV('TextFiles/TestInput2.txt')
			response.status.should eql(Status::FAILURE)
		end

		it "returns the minimum clicks for the sequence given in the configuration" do
			@user.setupTV('TextFiles/TestInput3.txt')
			navResponse = @user.navigateSequence
			navResponse.clicks.should eql(12)
			navResponse.status.should eql(Status::SUCCESS)
		end

		it "returns the minimum clicks for the sequence given in the configuration" do
			@user.setupTV('TextFiles/TestInput4.txt')
			navResponse = @user.navigateSequence
			navResponse.clicks.should eql(7)
			navResponse.status.should eql(Status::SUCCESS)
		end
	end
	
end