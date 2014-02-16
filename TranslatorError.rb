# TranslatorError is derived from StandardError
# It is raised in cases when our validations fail

class TranslatorError < StandardError
	attr_reader :object
	attr_reader :message

	def initialize(object, message)
		@object = object
		@message = message	
	end
	
end