require_relative './ConfigProcessor.rb'
require_relative './ConfigReader.rb'
require_relative './ConfigValidator.rb'
require_relative './Vocabulary.rb'
require_relative './RequestValidator.rb'
require_relative './UnitConverter.rb'
require_relative './ComputeMetal.rb'
require_relative './TranslatorError.rb'

# Exposes a public interface "getCredits"

class Transaction
	def initialize()
		config = ConfigReader.instance
		@parser = ConfigProcessor.new(config)
		@parser.process

		cfgValidator = ConfigValidator.new(@parser)
		cfgValidator.validateConfig
		cfgValidator.validateLanguage

		@converter = UnitConverter.new(@parser)
	end

	def getCredits(input, response)
		begin
			# Validates the request against library
			validateRequest input			

			# Gets the roman value for the input
			romanStr = @converter.unitToRoman input		

			# Checks if the given roman is valid
			validateRoman romanStr			

			# Gets the decimal equivalent for roman
			decVal = @converter.romanToDec romanStr

			# If the input has metal, then get the single value 
			# then compute credits by multiplying with the given  
			# input else return just the dec equivalent for roman
			if hasMetal(input)
				metalValue = getMetalValue input.split(" ").last 
				output = decVal.to_f * metalValue.to_f
			else
				output = decVal
			end
		rescue TranslatorError => e
			response.status = Status::FAILURE
			response.err_msg = e.message
			response.object = e.object
			return response
		else
			response.status = Status::SUCCESS
			response.err_msg = "Transaction Successful..."
			response.credits = output
			return response
		end
	end

	def validateRequest input
		reqValidator = RequestValidator.new(@parser)
		reqValidator.validateRequest input
	end

	def validateRoman input
		langChecker = LanguageChecker.new
		raise TranslatorError.new(Transaction, 
			ErrorMsg::INVALID_ROMAN) unless langChecker.roman? input
	end

	def hasMetal input
		["Silver","Gold","Iron"].include? input.split(" ").last
	end

	def getMetalValue metal
		computeMetal = ComputeMetal.new(@parser)
		silver, gold, iron = computeMetal.computeMetals

		case metal
			when "Silver"
				silver

			when "Gold"
				gold

			when "Iron"
				iron
		end
	end

	private :validateRequest, :validateRoman
	private :hasMetal, :getMetalValue

end


