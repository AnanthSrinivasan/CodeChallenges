require_relative "./TranslatorError.rb"
require_relative "./Constants.rb"
require_relative "./Vocabulary.rb"
# Request Validator validates if the given input 
# has contents only from the vocabulary

class RequestValidator
	
	def initialize(parsedConfig)
		@vocabulary = Vocabulary.new(parsedConfig)
		@vocabulary.build
	end
	
	def validateRequest input
		validateLanguage input
		validateMetalPos input
	end

	# Validates whether the input is in recognizable language
	def validateLanguage input
		input.split(" ").each { |key| 
			raise TranslatorError.new(RequestValidator, 
				ErrorMsg::INVALID_KEY) unless @vocabulary.find key
		 }
	end

	# If input has metal then it should be in the end.
	def validateMetalPos input
		if !["Silver","Gold","Iron"].include? input.split(" ").last
			raise TranslatorError.new(RequestValidator, 
				ErrorMsg::INVALID_POSITION) 
		end
	end

	private :validateLanguage, :validateMetalPos

end
