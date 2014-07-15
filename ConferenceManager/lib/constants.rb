require "ruby-enum"

LIGHTNING = 5
LUNCH = "Lunch"
NETWORKING = "Networking"

class Status
	include Ruby::Enum

	define :SUCCESS, "success"
	define :FAILURE, "failure"
end