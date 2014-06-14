require_relative './ConfigProcessor.rb'
require_relative './ConfigReader.rb'
require_relative "./LanguageChecker.rb"
require_relative './TranslatorError.rb'
require_relative "./Constants.rb"

# Validates whether the given configuration is as per 
# the language regulations. This is important because, 
# the system provides credits for the input based on 
# the standard mentioned in the configuration file.

class ConfigValidator
	
	def initialize()

	end
	
	def validate unitHash, txnHash
		validateConfig unitHash, txnHash
		validateLanguage unitHash, txnHash
	end

	def validateConfig unitHash, txnHash
		if (unitHash.empty? || txnHash.empty?)
			raise TranslatorError.new(ConfigValidator, 
				ErrorMsg::MISSING_CONFIG) 
		end
	end

	def validateLanguage unitHash, txnHash
		langChecker = LanguageChecker.new

		txnHash.each_key { |key|  
			val = ""			
			key.split(" ").each { |k|
				if unitHash.has_key?(k)
					val = val + unitHash[k]
				end 
			}
			raise TranslatorError.new(ConfigValidator, 
				ErrorMsg::INVALID_CONFIG) unless langChecker.roman? val
		}
		puts 'Config Validation Successful...'
	end

	private :validateConfig, :validateLanguage

end

