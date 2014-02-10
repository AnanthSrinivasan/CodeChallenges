require_relative "./ConfigReader.rb"
require_relative "./ConfigProcessor.rb"
require_relative "./UnitConverter.rb"

# This class computes the single value for the metals
# involved in the transaction from the configuration

class ComputeMetal
	def initialize(parsedConfig)
		@cfgProcessed = parsedConfig
		@converter = UnitConverter.new(@cfgProcessed)

		@silver = 0
		@gold = 0
		@iron = 0

		@metalHash = {}
	end

	def buildMetalHash
		txnHash = @cfgProcessed.transactions
		txnHash.each_pair { |key, value|
			val = @converter.unitToRoman key
			k = val + " " + key.split(" ").last
			@metalHash[k] = value
		}
		return @metalHash
	end

	def segregateMetals
		@metalHash.each_pair { |key, val|  
			metal = key.split(" ").last		#metal name
			credits = val.split(" ").first	#credit value
			romanStr = key.split(" ")[0]	#roman value
			quantity = @converter.romanToDec(romanStr)

			case metal
				when "Silver"
					@silver = computeValue(quantity, credits)

				when "Gold"
					@gold = computeValue(quantity, credits)

				when "Iron"
					@iron = computeValue(quantity, credits)
			end
		}
	end

	def computeValue quantity, credits
		metalValue = credits.to_f / quantity.to_f
	end

	def silver
		@silver
	end

	def gold
		@gold

	end

	def iron
		@iron
	end

end


