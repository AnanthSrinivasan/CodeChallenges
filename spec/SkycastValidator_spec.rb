require_relative '../lib/SkycastValidator.rb'
require_relative '../lib/FileProcessor.rb'

describe SkycastValidator do

	before :each do
		contents = FileProcessor.instance.fileContents
		@csValidator = SkycastValidator.new contents
	end

	describe "#new" do
		it "raises error when wrong number of arguments passed" do
			expect{ SkycastValidator.new }.to raise_error( ArgumentError )
		end

		it "takes Configobject as parameter and returns SkycastValidator" do
			@csValidator.should be_an_instance_of SkycastValidator
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
		after :each do
			expect{ @csValidator.validate }.to raise_error( ValidationError )
		end

		# Missing Elements Test
		it "validates lowestChannel element is missing" do
			@csValidator.config.lowestChannel = nil
		end

		it "validates highestChannel element is missing" do
			@csValidator.config.highestChannel = nil
		end

		it "validates blockedChannel is empty" do
			@csValidator.config.blockedChannel = []
		end

		it "validates navigationSequence is empty" do
			@csValidator.config.navigationSequence = []
		end
		# End - Missing Elements Test

		# Non Number Test
		it "validates lowestChannel contains non number" do
			@csValidator.config.lowestChannel = "b"
		end

		it "validates highestChannel contains non number" do
			@csValidator.config.highestChannel = "a"
		end

		it "validates blockedChannel contains non number" do
			@csValidator.config.blockedChannel = ["abc", "19"]
		end

		it "validates navigationSequence contains non number" do
			@csValidator.config.navigationSequence = ["14", "19", "df", "22"]
		end
		# End - Non Number Test

		# Count Match Test
		it "validates blockedChannelCount and blockedChannel size matches" do
			@csValidator.config.blockedChannelCount = 2
			@csValidator.config.blockedChannel = ["18", "19", "20"]
		end

		it "validates viewableChannelCount and navigationSequence size matches" do
			@csValidator.config.viewableChannelCount = 2
			@csValidator.config.navigationSequence = ["18", "20", "21"]
		end
		# End - Count Match Test

		# Channel Range Test
		it "validates lowestChannel is in range as per constraints" do
			@csValidator.config.lowestChannel = "0"
			@csValidator.config.highestChannel = "20"
		end

		it "validates highestChannel is in range per constraints" do
			@csValidator.config.lowestChannel = "1"
			@csValidator.config.highestChannel = "10001"
		end

		it "validates lowestChannel is lesser or equal to highestChannel" do
			@csValidator.config.lowestChannel = "20"
			@csValidator.config.highestChannel = "10"
		end
		# End - Channel Range Test

		# Max Count Test
		it "validates blockedChannelCount to be max of only 40 elements" do
			@csValidator.config.blockedChannelCount = 42
		end

		it "validates viewableChannelCount to be max of 50 elements" do
			@csValidator.config.viewableChannelCount = 52
		end
		# End - Max Count Test

		# BlockedChannels Range Test
		it "validates blockedChannels are in range against lowestChannel" do
			@csValidator.config.lowestChannel = "13"
			@csValidator.config.blockedChannel = ["12", "15"]
		end

		it "validates blockedChannels are in range against highestChannel" do
			@csValidator.config.highestChannel = "14"
			@csValidator.config.blockedChannel = ["12", "16"]
		end
		# End - BlockedChannels Range Test

		# NavigationSequence Range Test
		it "validates navigationSequence is in range against lowestChannel" do
			@csValidator.config.lowestChannel = "2"
			@csValidator.config.navigationSequence = ["15", "14", "17", "1", "17"]
		end

		it "validates navigationSequence is in range against highestChannel" do
			@csValidator.config.highestChannel = "19"
			@csValidator.config.navigationSequence = ["15", "14", "17", "1", "20"]
		end
		# End - NavigationSequence Range Test

		# Intersection Test
		it "validates navigationSequence elements are not in the blocked list" do
			@csValidator.config.blockedChannelCount = 3
			@csValidator.config.blockedChannel = ["13", "16", "20"]
			@csValidator.config.navigationSequence = ["15", "12", "17", "1", "20"]
		end
		# End - Intersection Test

	end	
end

