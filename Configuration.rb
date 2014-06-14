require_relative "./ConfigReader.rb"
require_relative "./ConfigProcessor.rb"
require_relative "./ConfigValidator.rb"
require_relative "./Vocabulary.rb"
require_relative "./ComputeMetal.rb"
require_relative "./ConfigObject.rb"

# Configuration class is responsible for the following
# 1. Reads the configuration
# 2. Processes the configuration
# 3. Builds the vocabulary out of configuration
# 4. Computes the single piece values of each metals
# 5. Returns the fully baked configObject 

class Configuration

	def initialize()
		@configObject = ConfigObject.new
	end
	
	def getConfig
		unitHash = {}
		txnHash = {}
		# Split and store the config data into unit and txn Hash
		unitHash, txnHash = readConfig

		# Validates the configuration 
		validateConfig(unitHash, txnHash)

		# Builds the vocabulary
		vocabArray = configVocabulary(unitHash, txnHash)

		# Generates the metal values 
		metalArray = configMetals(unitHash, txnHash)

		# Finally construct the fully baked config Object and return
		constructObject(unitHash, txnHash, vocabArray, metalArray)

		return @configObject
	end

	def readConfig
		config = ConfigReader.instance
		parser = ConfigProcessor.new(config)
		parser.process
	end

	def validateConfig unitHash, txnHash
		cfgValidator = ConfigValidator.new
		cfgValidator.validate(unitHash, txnHash)
	end

	def configVocabulary unitHash, txnHash
		vocabulary = Vocabulary.new
		vocabulary.buildVocabulary(unitHash, txnHash)
	end

	def configMetals unitHash, txnHash
		metals = ComputeMetal.new
		metals.computeMetals(unitHash, txnHash)
	end

	def constructObject unitHash, txnHash, vocabArray, metalArray
		@configObject.txnHash = txnHash
		@configObject.unitHash = unitHash
		@configObject.vocabulary = vocabArray
		@configObject.metalArray = metalArray
	end

	private :readConfig, :validateConfig
	private :configVocabulary, :constructObject

end