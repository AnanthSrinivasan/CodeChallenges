require "roman-numerals"
require_relative "./LanguageChecker.rb"

class UnitConverter

	def initialize()

		@base_digits = {
		1    => 'I',
		4    => 'IV',
		5    => 'V',
		9    => 'IX',
		10   => 'X',
		40   => 'XL',
		50   => 'L',
		90   => 'XC',
		100  => 'C',
		400  => 'CD',
		500  => 'D',
		900  => 'CM',
		1000 => 'M'
		}

	end
	
	def convert input, unitHash
		val = ""
		input.split(" ").each { |unit|
			if unitHash.has_key?(unit)
				if roman? unitHash[unit]
					val = val + romanToDec(unitHash[unit])
				elsif binary? unitHash[unit]
					val = val + unitToBinary(unitHash[unit]).to_s
				end
			end
		}	
		val
	end

	def roman? input
		@base_digits.has_value? input
	end

	def binary? input
		input.split("").all? { |element| ["0", "1"].include? element }
	end

	def unitToRoman input

	end

	def unitToBinary input
		input.to_i(2)
	end	

	def romanToDec input
		RomanNumerals.to_decimal(input)		
	end

	def to_decimal(value)

		value.upcase!
		result = 0
		@base_digits.values.reverse.each do |roman|
		  while value.start_with? roman
		    value = value.slice(roman.length, value.length)
		    result += @base_digits.key roman
		  end
		end
		result
	end

end
