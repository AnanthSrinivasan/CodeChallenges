# This class is responsible for building the vocabulary.
# Since we don't define any special meaning to the keys
# in the vocabulary, we delegate the job of finding 
# whether a key is present or not into the same object

class Vocabulary

	def initialize(parsedConfig)
		@vocabArray = []
		@cfgProcessed = parsedConfig
	end
	
	# Builds the vocabulary from the configuration
	def build
		unitHash = @cfgProcessed.units
		txnHash = @cfgProcessed.transactions

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

	# Find whether a key is present in the vocabulary
	def find key
		@vocabArray.include? key
	end

end
