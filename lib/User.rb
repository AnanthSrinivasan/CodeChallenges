require_relative "./FileProcessor.rb"
require_relative "./SkycastSTB.rb"
require_relative "./Remote.rb"
require_relative "./ClicksCalculator.rb"
require_relative "./Response.rb"
require_relative "./ValidationError.rb"

# User is the orchestrator who wants to navigate through the
# given sequence as given in the configuration

# Steps:
# 1. Load the configuration from the file
# 2. Apply the configuration to the SkycastSTB
# 3. Pair up the remote with the stb
# 4. Identify minimum clicks required to navigate
#	 step by step to complete the sequence
# 5. Use the remote object to navigate the sequence
# 6. Once navigation complets, return the clicks

class User

	def initialize
		@config = nil
	end
	
	def navigateSequence filename
		begin
			response = Response.new
			@config = FileProcessor.instance.fileContents(filename)

			stb = SkycastSTB.new
			stb.applyConfiguration @config

			remote = Remote.new
			remote.pairUp stb

			# get the clicks required for each step
			# while stb boots up it stays in the default channel hence we 
			# have to navigate from the default channel to first channel 
			# in the sequence and then proceed in the sequence. 
			clkCalcResponse = getClicksAndAction(@config.lowestChannel, 
											@config.navigationSequence.first)
			sumClicks = clkCalcResponse.clicks

			@config.navigationSequence.each_with_index do |element, index|
				clkCalcResponse = getClicksAndAction(@config.navigationSequence[index], 
											@config.navigationSequence[index+1])
				sumClicks += clkCalcResponse.clicks
				break if index == @config.navigationSequence.size-2
			end

		rescue ValidationError => e 
			response.status = Status::FAILURE
			response.err_msg = e.message
			response.object = e.object
			return response
		else
			response.status = Status::SUCCESS
			response.err_msg = "Navigation Completed..."
			response.clicks = sumClicks
			return response
		end
	end

	def getClicksAndAction source, target
		clicksCalculator = ClicksCalculator.new 
		clkCalcRequest = fillClicksCalculatorRequest source, target
		clkCalcResponse = clicksCalculator.getMinClicksAction(clkCalcRequest)
		return clkCalcResponse
	end

	def fillClicksCalculatorRequest source, target
		clkCalcRequest = ClicksCalculatorRequest.new 
		clkCalcRequest.source = source
		clkCalcRequest.target = target
		clkCalcRequest.blockedChannel = @config.blockedChannel
		clkCalcRequest.lowestChannel = @config.lowestChannel
		clkCalcRequest.highestChannel = @config.highestChannel
		return clkCalcRequest
	end
end


user = User.new
response = user.navigateSequence ('../TextFiles/Input.txt')
puts response.clicks

