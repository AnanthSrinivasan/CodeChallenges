require_relative "./ConfigReader.rb"

# Processor class gets the config and parses it.
# We split the configuration such that One hash stores the
# code and the corresponding roman, while the other one  
# stores the transaction and corresponding credits.
# Henceforth we can manipulate through these hashes. 

class ConfigProcessor

	def initialize(config)
		@txnHash = {}
		@unitHash = {}
		@cfg = config 	# ConfigReader instance...
	end

	def process
		@cfg.config.each_line do |line|
			key, value = line.chomp.split(" is ")
			if line[/(Silver|Gold|Iron)/].nil?
				@unitHash[key] = value
			else
				@txnHash[key] = value
			end
		end
	end

	def transactions
		@txnHash
	end

	def units
		@unitHash
	end	

end
