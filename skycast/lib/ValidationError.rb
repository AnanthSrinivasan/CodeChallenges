# Validation Error is raised in cases when our validations fail
# while applying configuration to our STB

class ValidationError < StandardError
	attr_reader :object
	attr_reader :message

	def initialize(object, message)
		@object = object
		@message = message	
	end
end