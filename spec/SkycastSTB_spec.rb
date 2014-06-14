require_relative "../lib/SkycastSTB.rb"
require_relative "../lib/FileProcessor.rb"

describe SkycastSTB do

	before :each do
		@config = FileProcessor.instance.fileContents('TextFiles/STBInput.txt')
	    @stb = SkycastSTB.new
	    @stb.applyConfiguration @config
	end	

	describe "#new" do
		it "creates a SkycastSTB object" do
			@stb.should be_an_instance_of SkycastSTB
		end
	end

	describe "#defaultChannel" do
		it "returns the default channel" do
			@stb.defaultChannel.should eql(@config.lowestChannel.to_i)
		end
	end

	describe "#previousChannel" do
		it "returns the previous channel" do
			@stb.previousChannel.should eql(@config.lowestChannel.to_i)
		end
	end

	describe "#currentChannel" do
		it "returns the current channel" do
			@stb.currentChannel.should eql(@config.lowestChannel.to_i)
		end
	end

	describe "#applyConfig" do
		it "applies the configuration to the stb and performs validation" do
			config = FileProcessor.instance.fileContents('TextFiles/TestInput2.txt')
			expect{ @stb.applyConfiguration config }.to raise_error(ValidationError)
		end
	end

	describe "#channelUp" do
		it "increments the currentChannel by 1" do
			@stb.currentChannel = 15
			@stb.channelUp
			@stb.currentChannel.should eql(16)
		end

		it "increments the currentChannel by 1 and skips the blocked channels" do
			@config.lowestChannel = 103
			@config.highestChannel = 108
			@config.blockedChannelCount = 1
			@config.navigationSequence = [105, 106, 107, 103, 105]
			@config.blockedChannel = [104]
			@stb.applyConfiguration @config
			@stb.currentChannel = 107
			@stb.channelUp
			@stb.channelUp
			@stb.currentChannel.should eql(103)
		end

		it "increments the currentChannel by 1 and rotates back if highest is hit" do
			@config.blockedChannel = [18, 19]
			@config.navigationSequence = [17, 14, 17, 5, 17]
			@stb.applyConfiguration @config
			@stb.currentChannel = 20
			@stb.channelUp
			@stb.currentChannel.should eql(1)
		end

		it "increments the currentChannel by 1, rotates back and considers blocked channels" do
			@config.blockedChannel = [2, 3]
			@config.navigationSequence = [17, 14, 17, 5, 17]
			@stb.applyConfiguration @config
			@stb.currentChannel = 20
			@stb.channelUp
			@stb.currentChannel.should eql(1)
		end
	end

	describe "#channelDown" do
		it "decrements the currentChannel by 1" do
			@stb.currentChannel = 15
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

		it "decrements the currentChannel by 1, rotates back and considers blocked channels" do
			@config.blockedChannel = [18, 19]
			@stb.applyConfiguration @config
			@stb.currentChannel = 1
			@stb.channelDown
			@stb.channelDown
			@stb.currentChannel.should eql(17)
		end
	end

	describe "#channelBack" do
		it "revert backs to the previousChannel" do
			@stb.currentChannel = 15
			@stb.channelUp # - 16
			@stb.channelBack # - 15
			@stb.channelBack # - 16
			@stb.currentChannel.should eql(16)
		end
	end

	describe "#channelNumber" do
		it "applies the given channel and sets it to currentChannel" do
			@stb.previousChannel = 1
			@stb.currentChannel = 15

			@stb.channelNumber('1')
			@stb.channelNumber('4')

			@stb.channelNumber('1')
			@stb.channelNumber('7')

			@stb.currentChannel.should eql(17)
		end
	end

end