require_relative '../lib/configuration.rb'
require_relative '../lib/configobject.rb'

describe "Configuration" do

	before :each do
		@cfg = Configuration.new
	end

	describe "#getConfig" do
		it "returns a config object" do
			@cfg.getConfig.should be_an_instance_of Configobject
		end

		it "has a range of channels" do
			@cfg.getConfig.rangeHash.should be_an_instance_of Hash 
		end

		it "has an array of blocked channels" do
			@cfg.getConfig.blockedChannel.should be_an_instance_of Array 
		end

		it "has an array of viewable channels" do
			@cfg.getConfig.blockedChannel.should be_an_instance_of Array 
		end

	end



end
# test = Configuration.new
# @cfg = test.getConfig

# puts @cfg.rangeHash.inspect
# puts @cfg.blockedChannelCount
# puts @cfg.blockedChannel.inspect
# puts @cfg.viewableChannelCount
# puts @cfg.navigationSequence.inspect

