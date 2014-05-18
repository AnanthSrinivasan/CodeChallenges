require_relative "../lib/SkycastSTB.rb"
require_relative "../lib/FileProcessor.rb"

describe SkycastSTB do

	before :each do
		@config = FileProcessor.instance.fileContents('TextFiles/Input.txt')
	    @stb = SkycastSTB.new
	    @stb.applyConfiguration @config
	end	

	describe "#new" do
		it "takes configuration as parameter and returns a SkycastSTB object" do
			@stb.should be_an_instance_of SkycastSTB
		end
	end

	describe "#defaultChannel" do
		it "returns the default channel" do
			@stb.defaultChannel.should eql(1)
		end
	end

	describe "#previousChannel" do
		it "returns the previous channel" do
			@stb.previousChannel.should eql(1)
		end
	end

	describe "#currentChannel" do
		it "returns the current channel" do
			@stb.currentChannel.should eql(15)
		end
	end

	describe "#applyConfig" do
		it "applies the configuration to the stb and performs validation" do
			config = FileProcessor.instance.fileContents('TextFiles/TestInput.txt')
			expect{ @stb.applyConfiguration config }.to raise_error(ValidationError)
		end
	end

	describe "#channelUp" do
		it "increments the currentChannel by 1" do
			@stb.channelUp
			@stb.currentChannel.should eql(16)
		end

		it "increments the currentChannel by 1 and skips the blocked channels" do
			@config.navigationSequence = [17, 14, 17, 1, 17]
			@stb.applyConfiguration @config
			@stb.channelUp
			@stb.currentChannel.should eql(20)
		end

		it "increments the currentChannel by 1 and rotates back if highest is hit" do
			@config.blockedChannel = [18, 19]
			@config.navigationSequence = [17, 14, 17, 5, 17]
			@stb.applyConfiguration @config
			@stb.currentChannel = 20
			@stb.channelUp
			@stb.currentChannel.should eql(1)
		end

		it "increments the currentChannel by 1 and rotates back and considers blocked channels" do
			@config.blockedChannel = [1, 2]
			@config.navigationSequence = [17, 14, 17, 5, 17]
			@stb.applyConfiguration @config
			@stb.currentChannel = 20
			@stb.channelUp
			@stb.currentChannel.should eql(3)
		end
	end

	describe "#channelDown" do
		it "decrements the currentChannel by 1" do
			@stb.channelDown
			@stb.currentChannel.should eql(14)
		end

		it "decrements the currentChannel by 1 and skips the blocked channels" do
			@stb.applyConfiguration @config
			@stb.currentChannel = 20
			@stb.channelDown
			@stb.currentChannel.should eql(17)
		end

		it "decrements the currentChannel by 1 and rotates back if lowest is hit" do
			@stb.applyConfiguration @config
			@stb.currentChannel = 1
			@stb.channelDown
			@stb.currentChannel.should eql(20)
		end

		it "increments the currentChannel by 1 and rotates back and considers blocked channels" do
			@config.blockedChannel = [19, 20]
			@stb.applyConfiguration @config
			@stb.currentChannel = 1
			@stb.channelDown
			@stb.currentChannel.should eql(18)
		end
	end

	describe "#channelBack" do
		it "revert backs to the previousChannel" do
			@stb.channelUp # - 16
			@stb.channelBack # - 15
			@stb.channelBack # - 16
			@stb.currentChannel.should eql(16)
		end

	end

end