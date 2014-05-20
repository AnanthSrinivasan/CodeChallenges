require_relative "./FileProcessor.rb"
require_relative "./SkycastSTB.rb"
require_relative "./Remote.rb"
require_relative "./ClicksCalculator.rb"
require_relative "./Response.rb"
require_relative "./ValidationError.rb"

# User is the orchestrator who wants to navigate through the
# given sequence as given in the configuration

# Steps:
# Setup the tv:
# 1. Load the configuration from the file
# 2. Apply the configuration to the SkycastSTB
# 3. Pair up the remote with the stb
# Navigate the sequence: 
# 4. Identify minimum clicks required to navigate
#	 step by step to complete the sequence
# 5. Use the remote object to navigate the sequence
# 6. Once navigation complets, return the clicks

class User

	def setupTV filename
		response = Response.new
		begin
			@config = FileProcessor.instance.fileContents(filename)
			@stb = SkycastSTB.new
			@stb.applyConfiguration @config

			@remote = Remote.new
			@remote.pairUp @stb
		rescue ValidationError => e
			response.status = Status::FAILURE
			response.err_msg = "TV Setup Failed..." + e.message
			response.object = e.object
			return response
		else
			response.status = Status::SUCCESS
			response.err_msg = "TV Setup Completed..."
			return response
		end
	end
	
	def navigateSequence
		begin
			response = Response.new
			# get the clicks required for each step
			# while stb boots up it stays in the default channel hence we 
			# have to navigate from the default channel to first channel 
			# in the sequence and then proceed through the sequence. 
			printSourceTarget(@config.lowestChannel, @config.navigationSequence.first)
			clkCalcResponse = getClicksAndAction(@config.lowestChannel , 
											@config.navigationSequence.first)

			sumClicks = clkCalcResponse.clicks
			puts "#{sumClicks} clicks"
			performActionOnSTB(clkCalcResponse.action, 
							   clkCalcResponse.clicks, 
							   @config.navigationSequence.first)

			@config.navigationSequence.each_with_index do |element, index|

				source = @config.navigationSequence[index]
				target = @config.navigationSequence[index+1]

				printSourceTarget(source, target)

				clkCalcResponse = getClicksAndAction(source, target)

				action = clkCalcResponse.action 
				clicks = clkCalcResponse.clicks

				# Override action and clicks if we can reach 
				# the target through back action. 
				if @stb.previousChannel == target
					clicks = 1
					action = Action::BACK
				end

				puts "#{clicks} clicks"
				performActionOnSTB action, clicks, target

				sumClicks += clicks
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

	def invokeAction action, number
		puts "Remote action : #{action}"
		case action
			when Action::UP
				@remote.pressButton('u')
			when Action::DOWN
				@remote.pressButton('d')
			when Action::NUMBER
				@remote.pressButton(number.to_s)
			when Action::BACK
				@remote.pressButton('b')
		end	
	end

	def performActionOnSTB action, clicks, target
		if action != Action::NUMBER
			@stb.previousChannel = @stb.currentChannel if clicks == 0
			clicks.times do
				invokeAction action, 0
			end
		else
			target.to_s.chars.map(&:to_i).each do |number|
				invokeAction(action, number)
			end
		end
	end

	def printSourceTarget source, target
		puts "Source : #{source}"
		puts "Target : #{target}"
	end

end


user = User.new
response = user.setupTV('../TextFiles/Input.txt')
response = user.navigateSequence 
puts response.clicks

