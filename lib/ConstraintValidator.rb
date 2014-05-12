require_relative './ValidationError.rb'
require_relative './Constants.rb'
# Validates whether the given configuration is as per 
# the constraints. Raise error if any of the constraints
# are violated. 

class ConstraintValidator
	attr_accessor :config

	def initialize configuration
		@config = configuration
	end
	
	def validate 
		#check if any of the expected config elements are missing
		missingConfig

		#check if any of the config element is not a number
		#nan? 
	end

	def missingConfig
		if ( @config.rangeHash.values.any? { |val| val.nil? } ||
			 @config.blockedChannel.empty? ||
			 @config.navigationSequence.empty? )	

			raise ValidationError.new(ConstraintValidator, 
					ErrorMsg::MISSING_CONFIG) 
		end
	end

	# def nan?

	# 	raise ValidationError.new(ConstraintValidator, 
	# 			ErrorMsg::MISSING_CONFIG) 
	# end

	# def validateRange 
	# end

	# def validateBlockedChannels
	# end


	# private :validateRange, :validateBlockedChannels

end

