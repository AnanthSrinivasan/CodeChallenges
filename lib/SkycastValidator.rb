require_relative './ValidationError.rb'
require_relative './Constants.rb'
# Validates whether the given configuration is as per the STB constraints. 
# Raise error if any of the constraints are violated. 

class SkycastValidator
	attr_accessor :config

	def initialize configuration
		@config = configuration
	end
	
	def validate 
		#boundary conditions to check with the given configuration
		boundaryCheck

		#constraints to check for the system
		constraintCheck
	end

	def boundaryCheck
		#check if any of the expected config elements are missing
		missingConfig

		#check if any of the config element is not a number
		nan

		#check if the count of blocked and viewable channels match 
		countCheck
	end

	def constraintCheck
		#check the lowest and highest channel constraints
		lowHighRange

		#check the range and constraints for blocked channels
		blockedChannelRange

		#check the range and constraints for viewable channels
		navigationSequenceRange

		#check if there are any intersections in blocked and
		#viewable channels
		commonality
	end

	def missingConfig
		if ( @config.lowestChannel.nil? 		||
			 @config.highestChannel.nil? 		||
			 @config.blockedChannel.empty? 		||
			 @config.navigationSequence.empty? )	
			raise ValidationError.new(SkycastValidator, 
					ErrorMsg::MISSING_CONFIG) 
		end
	end

	def nan
		if ( !number?(@config.lowestChannel) 						|| 
			 !number?(@config.highestChannel) 						||
			 @config.blockedChannel.any? { |val| !(number? val) }   ||
			 @config.navigationSequence.any? { |val| !(number? val) } ) 	
			raise ValidationError.new(SkycastValidator, 
					ErrorMsg::NON_NUMBER_PRESENT_IN_CONFIG) 
		end
	end

	def countCheck
		if ( @config.blockedChannelCount != @config.blockedChannel.size ||
			@config.viewableChannelCount != @config.navigationSequence.size )
			raise ValidationError.new(SkycastValidator, 
					ErrorMsg::COUNT_MISMATCH) 
		end
	end

	def lowHighRange
		if ( @config.lowestChannel <= 0		|| 
			 @config.highestChannel > 10000 ||
			 @config.highestChannel < @config.lowestChannel )
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::CHANNELS_NOT_IN_RANGE) 
		end
	end

	def blockedChannelRange
		blockedChannelCount
		
		blockedChannelBoundary
	end

	def navigationSequenceRange
		navigationSequenceCount

		navigationSequenceBoundary
	end

	def blockedChannelCount
		if ( @config.blockedChannelCount > 40)
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::BLOCKED_CHANNEL_COUNT_EXCEEDED) 
		end
	end

	def blockedChannelBoundary
		if ( @config.blockedChannel.any? { |val| 
			val < @config.lowestChannel  ||
			val > @config.highestChannel } )
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::BLOCKED_CHANNEL_RANGE_EXCEEDED) 
		end
	end

	def navigationSequenceCount
		if (@config.viewableChannelCount > 50)
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::NAVIGATION_SEQUENCE_COUNT_EXCEEDED) 
		end
	end

	def navigationSequenceBoundary
		if ( @config.navigationSequence.any? { |val| 
			val < @config.lowestChannel 	||
			val > @config.highestChannel 	})
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::NAVIGATION_SEQUENCE_RANGE_EXCEEDED) 
		end
	end

	def commonality
		if !( @config.blockedChannel & 
				@config.navigationSequence ).empty?
			raise ValidationError.new(SkycastValidator, 
				ErrorMsg::COMMONALITY_PRESENT) 		
		end
	end

	def number?(o)
	    true if Integer(o) rescue false
	end

	private :boundaryCheck, :constraintCheck,
			:missingConfig, :nan, :countCheck,
			:lowHighRange, :blockedChannelRange, 
			:navigationSequenceRange, :commonality,
			:blockedChannelCount, :blockedChannelBoundary,
			:navigationSequenceCount, :navigationSequenceBoundary
end


