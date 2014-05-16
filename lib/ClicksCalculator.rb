require_relative './ClicksCalculatorRequest.rb'
require_relative "./ClicksCalculatorResponse.rb"

# Calculates the number of clicks required to move from source to target
# getMinClicksAction is the exposed interface which returns the response
class ClicksCalculator

	# Note: members are initialized only in initMembers and 
	# are not set again by any function, we are doing this to
	# avoid duplication of code. Better way is to pass the required
	# data around to the specific function. Since we are not setting
	# any members outside of this function it is ok to put in one place
	def initMembers clicksCalculatorRequest
		@lowestChannel = clicksCalculatorRequest.lowestChannel
		@highestChannel = clicksCalculatorRequest.highestChannel
		@source = clicksCalculatorRequest.source
		@target = clicksCalculatorRequest.target
		@blockedList = clicksCalculatorRequest.blockedChannel
		@blockedList.map! { |e| e.to_i }
	end

	def getMinClicksAction(clicksCalculatorRequest)
		initMembers clicksCalculatorRequest

		upClicks = up 
		downClicks = down 
		numberClicks = number 

		minClicks = [upClicks, downClicks, numberClicks].min
		index = [upClicks, downClicks, numberClicks].index(minClicks)

		clicksCalculatorResponse = ClicksCalculatorResponse.new
		clicksCalculatorResponse.clicks = minClicks
		clicksCalculatorResponse.action = action index
		return clicksCalculatorResponse
	end

	def up 
		if (@source < @target) 	# 14 - 17
			@target - @source - channelsBlockedInRange
		elsif (@source > @target)
			((@highestChannel - @lowestChannel) - 
					(@source - @target) - channelsBlockedOutRange) + 1
		else
			0 # if source and target are same no Clicks are considered
		end
	end

	def down
		if (@source < @target) 	# 14 - 17
			((@highestChannel - @lowestChannel) - 
					(@target - @source) - channelsBlockedOutRange) + 1
		elsif (@source > @target)
			@source - @target - channelsBlockedInRange
		else
			0 
		end
	end

	def number 
		@target.to_s.size
	end

	def channelsInRange
		viewList = []
		if (@source < @target)
			(@source..@target).each {|chn| viewList.push(chn)}
		elsif(@source > @target)
			@source.downto(@target).each { |chn| viewList.push(chn) }
		end
		return viewList	
	end

	def channelsBlockedInRange
		(channelsInRange & @blockedList).count
	end

	def channelsBlockedOutRange
		@blockedList.count - channelsBlockedInRange
	end

	def action index
		case index
			when 0
				Action::UP
			when 1
				Action::DOWN
			when 2
				Action::NUMBER
			else
				Action::UNDEFINED
		end
	end

	private :initMembers, :up, :down, :number,
			:channelsInRange, :action,
			:channelsBlockedInRange, :channelsBlockedOutRange

end
