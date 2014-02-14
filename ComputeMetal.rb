require_relative "./ConfigReader.rb"
require_relative "./ConfigProcessor.rb"
require_relative "./UnitConverter.rb"

# This class computes the single value for the metals
# involved in the transaction based on the configuration

# computeMetals computes the value for each metals 
# and returns back. We don't want to have separate getters 
# for these metals as if it were to be a remote call 
# we would end up making three remote calls.

class ComputeMetal
	def initialize(parsedConfig)
		@cfgProcessed = parsedConfig
		@converter = UnitConverter.new(@cfgProcessed)

		@silver = 0
		@gold = 0
		@iron = 0
	end

	def computeMetals
		metalHash = buildMetalHash 

		segregateMetals metalHash

		return @silver, @gold, @iron
	end

	def buildMetalHash
		metalHash = {}
		txnHash = @cfgProcessed.transactions
		txnHash.each_pair { |key, value|
			val = @converter.unitToRoman key
			k = val + " " + key.split(" ").last
			metalHash[k] = value
		}
		return metalHash
	end

	def segregateMetals metalHash
		metalHash.each_pair { |key, val|  
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

	private :buildMetalHash, :segregateMetals, :computeValue

end


