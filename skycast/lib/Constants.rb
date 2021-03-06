require "ruby-enum"

class Status
	include Ruby::Enum

	define :SUCCESS, "success"
	define :FAILURE, "failure"
end

class Action
	include Ruby::Enum

	define :UP, "up"
	define :DOWN, "down"
	define :NUMBER, "number"
	define :BACK, "back"
	define :UNDEFINED, "undefined"
end

class ErrorMsg
	include Ruby::Enum

	define :MISSING_CONFIG, 
						"Missing Configuration..."
	define :NON_NUMBER_PRESENT_IN_CONFIG, 
						"Configuration has non number values..."
	define :COUNT_MISMATCH, 
						"Mismatch in count and array size..."
	define :CHANNELS_NOT_IN_RANGE, 
						"Channels are not in range per constraints..."
	define :BLOCKED_CHANNEL_COUNT_EXCEEDED, 
						"Blocked channels can be a max of 40 elements..."
	define :BLOCKED_CHANNEL_RANGE_EXCEEDED, 
						"Blocked channels contain elements which are out of range..."
	define :NAVIGATION_SEQUENCE_COUNT_EXCEEDED, 
						"Navigation sequence can be a max of 50 elements..."
	define :NAVIGATION_SEQUENCE_RANGE_EXCEEDED, 
						"Navigation sequence contain elements which are out of range..."
	define :COMMONALITY_PRESENT, 
						"Common elements present in blocked and viewable channels list..."
	define :INVALID_INPUT_TO_REMOTE,
						"Invalid button has been pressed..."						
	define :UNDEFINED, 
						"undefined..."
end
