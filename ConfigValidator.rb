# Validates whether the given configuration is as per 
# the language regulations. This is important because, 
# the system provides credits for the input based on 
# the standard mentioned in the configuration file.

require_relative "./LanguageChecker.rb"
require_relative './ConfigProcessor.rb'
require_relative './ConfigReader.rb'
require_relative './TranslatorError.rb'
require_relative "./Constants.rb"

class ConfigValidator
	def initialize(parsedConfig)
		@cfgProcessed = parsedConfig
	end
	
	def validateConfig
		if (@cfgProcessed.units.empty? || 
			@cfgProcessed.transactions.empty?)
			raise TranslatorError.new(ConfigValidator, 
				ErrorMsg::MISSING_CONFIG) 
		end
	end

	def validateLanguage
		txnHash = @cfgProcessed.transactions
		unitHash = @cfgProcessed.units
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

end

