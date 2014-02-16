require_relative "./TranslatorError.rb"
require_relative "./Constants.rb"
require_relative "./Vocabulary.rb"
# Request Validator validates if the given input 
# has contents only from the vocabulary

class RequestValidator
	
	def initialize

	end
	
	def validateRequest input, vocabArray
		validateLanguage(input, vocabArray)
		validateMetalPos input if containsMetal? input
	end

	# Validates whether the input is in recognizable language
	def validateLanguage input, vocabArray
		input.split(" ").each { |key| 
			raise TranslatorError.new(RequestValidator, 
				ErrorMsg::INVALID_KEY) unless vocabArray.include? key
		 }
	end

	# If input has metal then it should be in the end.
	def validateMetalPos input
		if !["Silver","Gold","Iron"].include? input.split(" ").last
			raise TranslatorError.new(RequestValidator, 
				ErrorMsg::INVALID_POSITION) 
		end
	end

	# Check if the input contains Metal in it?
	def containsMetal? input
		input.split(" ").each { |key| 
			return true if ["Silver","Gold","Iron"].include? key
		}
		return false
	end

	private :validateLanguage, :validateMetalPos, :containsMetal?

end
