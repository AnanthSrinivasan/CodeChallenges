require "ruby-enum"

class Status
	include Ruby::Enum

	define :SUCCESS, "success"
	define :FAILURE, "failure"
end

class ErrorMsg
	include Ruby::Enum

	define :MISSING_CONFIG, "Missing Configuration..."
	define :INVALID_CONFIG, "Invalid Configuration..."
	define :INVALID_KEY, "Unrecognized Language..."
	define :INVALID_ROMAN, "Invalid Roman Formation..."
	define :UNDEFINED, "undefined"
end
