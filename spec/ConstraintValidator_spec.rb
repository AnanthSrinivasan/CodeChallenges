require_relative '../lib/constraintvalidator.rb'
require_relative '../lib/fileprocessor.rb'

describe ConstraintValidator do

	before :all do
		@contents = FileProcessor.instance.fileContents
		@csValidator = ConstraintValidator.new @contents
	end

	describe "#new" do
		it "raises error when wrong number of arguments passed" do
			expect{ ConstraintValidator.new }.to raise_error( ArgumentError )
		end

		it "succeeds when right number of arguments passed" do
			expect{ ConstraintValidator.new @contents}.not_to raise_error
		end

	    it "takes Configobject as parameter" do
	    	cfgValidator = ConstraintValidator.new @contents
	    	@contents.should be_an_instance_of Configobject
	    end

		it "validates config to contain a range of channels" do
			@csValidator.config.rangeHash.should be_an_instance_of Hash 
		end

		it "validates config to contain an array of blocked channels" do
			@csValidator.config.blockedChannel.should be_an_instance_of Array 
		end

		it "validates config to contain an array of viewable channels" do
			@csValidator.config.navigationSequence.should be_an_instance_of Array 
		end
	end


	describe "#validate" do
		it "validates if any config element is missing" do
			csv = ConstraintValidator.new @contents
			testRange = {}
			testRange[:low] = nil
			testRange[:high] = 20
			csv.config.rangeHash = testRange
			expect{ csv.validate }.to raise_error( ValidationError )
		end

		# it "validates if rangeHash contains only numbers" do
		# 	@csValidator.validate.should raise_error (ValidationError) 	
		# end
		
	end	

end
