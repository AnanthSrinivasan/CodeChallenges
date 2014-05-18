require_relative "../lib/ClicksCalculator.rb"
require_relative "../lib/ClicksCalculatorRequest.rb"
require_relative "../lib/ClicksCalculatorResponse.rb"
require_relative "../lib/Constants.rb"

describe ClicksCalculator do

	before :each do
		@clkCalc = ClicksCalculator.new 
		@clkCalcRequest = ClicksCalculatorRequest.new 
		@clkCalcRequest.source = 14
		@clkCalcRequest.target = 17
		@clkCalcRequest.blockedChannel = [15, 18, 19]
		@clkCalcRequest.lowestChannel = 1
		@clkCalcRequest.highestChannel = 20
		@clkCalcResponse = ClicksCalculatorResponse.new
		@clkCalcResponse.action = Action::UNDEFINED
		@clkCalcResponse.clicks = -1
		@clkCalcResponse
	end

	describe "#getMinClicksAction" do
		it "takes ClicksCalculatorRequest and ClicksCalculatorResponse as a parameter" do
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
		end

		it "gives minimum clicks as part of ClicksCalculatorResponse" do
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should_not eql(-1)
		end

		it "gives action as part of ClicksCalculatorResponse" do
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.action.should_not eql(Action::UNDEFINED)
		end

		it "asserts 2 minimum clicks and up action required to move from 14 and 17" do
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(2)
			@clkCalcResponse.action.should eql(Action::UP)
		end

		it "asserts 2 minimum clicks and up action required to move from 107 to 103" do
			@clkCalcRequest.lowestChannel = 103
			@clkCalcRequest.highestChannel = 108
			@clkCalcRequest.blockedChannel = [104]
			@clkCalcRequest.source = 107
			@clkCalcRequest.target = 103
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(2)
			@clkCalcResponse.action.should eql(Action::UP)
		end

		it "asserts 3 minimum clicks and number action required to move from 1 to 100" do
			@clkCalcRequest.lowestChannel = 1
			@clkCalcRequest.highestChannel = 200
			@clkCalcRequest.blockedChannel = []
			@clkCalcRequest.source = 1
			@clkCalcRequest.target = 100
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(3)
			@clkCalcResponse.action.should eql(Action::NUMBER)
		end

		it "asserts 0 clicks required to move from 1 to 1" do
			@clkCalcRequest.lowestChannel = 1
			@clkCalcRequest.highestChannel = 200
			@clkCalcRequest.blockedChannel = []
			@clkCalcRequest.source = 1
			@clkCalcRequest.target = 1
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(0)
		end

		it "asserts 3 minimum clicks and number action required to move from 13 to 100" do
			@clkCalcRequest.lowestChannel = 1
			@clkCalcRequest.highestChannel = 200
			@clkCalcRequest.blockedChannel = [78, 79, 80, 3]
			@clkCalcRequest.source = 13
			@clkCalcRequest.target = 100
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(3)
			@clkCalcResponse.action.should eql(Action::NUMBER)
		end

		it "asserts 1 minimum click and up action required to move from 77 to 81" do
			@clkCalcRequest.lowestChannel = 1
			@clkCalcRequest.highestChannel = 100
			@clkCalcRequest.blockedChannel = [78, 79, 80, 3]
			@clkCalcRequest.source = 77
			@clkCalcRequest.target = 81
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(1)
			@clkCalcResponse.action.should eql(Action::UP)
		end

		it "asserts 1 minimum click and up action required to move from 106 to 107" do
			@clkCalcRequest.lowestChannel = 103
			@clkCalcRequest.highestChannel = 108
			@clkCalcRequest.blockedChannel = [104]
			@clkCalcRequest.source = 106
			@clkCalcRequest.target = 107
			@clkCalcResponse = @clkCalc.getMinClicksAction @clkCalcRequest
			@clkCalcResponse.clicks.should eql(1)
			@clkCalcResponse.action.should eql(Action::UP)
		end
	end

end