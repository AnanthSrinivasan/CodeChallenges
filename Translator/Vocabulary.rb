# This class is responsible for building the vocabulary
# based on the keys present in the configuration

class Vocabulary

	def initialize()
		@vocabArray = []
	end
	
	# Builds the vocabulary from the configuration
	def buildVocabulary unitHash, txnHash
		unitHash.keys.each { |code|
			@vocabArray.push(code)
		}

		txnHash.keys.each { |key|
			key.split(" ").each { |code|
				unless unitHash.has_key?(code)
					@vocabArray.push(code)
				end
			}
		}
		return @vocabArray
	end

end

