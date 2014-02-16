require "roman-numerals"
require_relative "./LanguageChecker.rb"

class UnitConverter

	def initialize()

	end
	
	def unitToRoman input, unitHash
		val = ""
		input.split(" ").each { |unit|
			if unitHash.has_key?(unit)
				val = val + unitHash[unit] 
			end
		}	
		return val
	end

	def romanToDec input
		RomanNumerals.to_decimal(input)		
	end

end
