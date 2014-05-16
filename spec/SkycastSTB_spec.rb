require_relative "../lib/SkycastSTB.rb"
require_relative "../lib/FileProcessor.rb"

describe SkycastSTB do

	before :each do
		config = FileProcessor.instance.fileContents
	    @stb = SkycastSTB.new
	    @stb.applyConfiguration config
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

	# describe "#applyConfig" do
	# 	it "applies the configuration to the stb" do
	# 		@stb.applyConfig
	# 	end
	# end

end