require_relative "./TranslatorError.rb"
require_relative "./Constants.rb"
# Request Validator takes the vocabulary object and
# validates the incoming request
# It sends back the response object
# Response object will contain status of the operation
# and the error message if the status is a failure

class RequestValidator
	
	def initialize(parsedConfig)
		@vocabulary = Vocabulary.new(parsedConfig)
		@vocabulary.build
	end
	
	# Validates whether the input is in recognizable language
	def validateLanguage input
		input.split(" ").each { |key| 
			raise TranslatorError.new(RequestValidator, 
				ErrorMsg::INVALID_KEY) unless @vocabulary.find key
		 }
	end

# if there is a metal it should be given as the last key.

end
