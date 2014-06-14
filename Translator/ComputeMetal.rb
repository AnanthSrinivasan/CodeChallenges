require_relative "./ConfigReader.rb"
require_relative "./ConfigProcessor.rb"
require_relative "./UnitConverter.rb"
require_relative "./MetalObject.rb"

# This class computes the single value for the metals
# involved in the transaction based on the configuration

# computeMetals computes the value for each metals 
# and returns the metalObject. We don't want to have separate 
# getters for these metals as if it were to be a remote call 
# then we would end up making three remote calls.

class ComputeMetal
	def initialize()
		@converter = UnitConverter.new 
	end

	def computeMetals unitHash, txnHash
		metalHash = buildMetalHash unitHash, txnHash
		metalArray = segregateMetals metalHash
		return metalArray
	end

	def buildMetalHash unitHash, txnHash
		metalHash = {}
		txnHash.each_pair { |key, value|
			val = @converter.unitToRoman key, unitHash
			k = val + " " + key.split(" ").last
			metalHash[k] = value
		}
		return metalHash
	end

	def segregateMetals metalHash
		metalObjArray = []
		metalHash.each_pair { |key, val|  	# II Silver = 34 C
			metal = key.split(" ").last		#metal name
			credits = val.split(" ").first	#credit value
			romanStr = key.split(" ")[0]	#roman value
			quantity = @converter.romanToDec(romanStr)

			metalObj = MetalObject.new
			metalObj.type = metal
			metalObj.value = computeValue(quantity, credits)
			metalObjArray.push (metalObj)
		}
		metalObjArray
	end

	def computeValue quantity, credits
		metalValue = credits.to_f / quantity.to_f
	end

	private :buildMetalHash, :segregateMetals, :computeValue

end


# case metal
# 	when "Silver"
# 		@metalObj.silver = computeValue(quantity, credits)

# 	when "Gold"
# 		@metalObj.gold = computeValue(quantity, credits)

# 	when "Iron"
# 		@metalObj.iron = computeValue(quantity, credits)
# end
