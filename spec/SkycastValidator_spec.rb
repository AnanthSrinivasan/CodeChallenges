require_relative '../lib/SkycastValidator.rb'
require_relative '../lib/FileProcessor.rb'

describe SkycastValidator do

	before :each do
		@contents = FileProcessor.instance.fileContents
		@csValidator = SkycastValidator.new @contents
	end

	describe "#new" do
		it "raises error when wrong number of arguments passed" do
			expect{ SkycastValidator.new }.to raise_error( ArgumentError )
		end

		it "succeeds when right number of arguments passed" do
			expect{ SkycastValidator.new @contents}.not_to raise_error
		end

	    it "takes Configobject as parameter" do
	    	cfgValidator = SkycastValidator.new @contents
	    	@contents.should be_an_instance_of Configobject
	    end

		it "validates lowest channel is present" do
			@csValidator.config.lowestChannel.should_not be_nil
		end

		it "validates highest channel is present" do
			@csValidator.config.highestChannel.should_not be_nil
		end

		it "validates config to contain an array of blocked channels" do
			@csValidator.config.blockedChannel.should be_an_instance_of Array 
		end

		it "validates config to contain an array of viewable channels" do
			@csValidator.config.navigationSequence.should be_an_instance_of Array 
		end
	end

	describe "#validate" do
		it "validates any config element is missing" do
			@csValidator.config.lowestChannel = nil
			@csValidator.config.highestChannel = nil
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.blockedChannel = []
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.navigationSequence = []
			expect{ @csValidator.validate }.to raise_error( ValidationError )			
		end

		it "validates any config element contains non number" do
			@csValidator.config.lowestChannel = "b"
			@csValidator.config.highestChannel = "20"
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.blockedChannel = ["abc", "19"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.navigationSequence = ["14", "19", "df", "22"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end
	
		it "validates blockedChannelCount and blockedChannel size matches" do
			@csValidator.config.blockedChannelCount = 2
			@csValidator.config.blockedChannel = ["18", "19", "20"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		it "validates viewableChannelCount and navigationSequence size matches" do
			@csValidator.config.viewableChannelCount = 2
			@csValidator.config.navigationSequence = ["18", "20", "21"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )			
		end

		it "validates range of channels to be within constraints" do
			@csValidator.config.lowestChannel = "0"
			@csValidator.config.highestChannel = "20"
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.lowestChannel = "1"
			@csValidator.config.highestChannel = "10001"
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.lowestChannel = "20"
			@csValidator.config.highestChannel = "10"
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		it "validates blockedChannelCount to be max of only 40 elements" do
			@csValidator.config.blockedChannelCount = 42
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		it "validates viewableChannelCount to be max of 50 elements" do
			@csValidator.config.viewableChannelCount = 52
			expect{ @csValidator.validate }.to raise_error( ValidationError )			
		end

		it "validates blockedChannels are within the range" do
			@csValidator.config.lowestChannel = "13"
			@csValidator.config.blockedChannel = ["12", "15"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.highestChannel = "14"
			@csValidator.config.blockedChannel = ["12", "16"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		it "validates navigationSequence is within the range" do
			@csValidator.config.lowestChannel = "1"
			@csValidator.config.navigationSequence = ["15", "14", "17", "0", "17"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )

			@csValidator.config.highestChannel = "19"
			@csValidator.config.navigationSequence = ["15", "14", "17", "1", "20"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		it "validates navigationSequence elements are not in the blocked list" do
			@csValidator.config.blockedChannelCount = 3
			@csValidator.config.blockedChannel = ["13", "16", "20"]
			@csValidator.config.navigationSequence = ["15", "12", "17", "1", "20"]
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end
	end	
end

