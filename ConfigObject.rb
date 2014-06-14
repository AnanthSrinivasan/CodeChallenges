# ConfigObject will be the middle man used both by the
# domain as well as the input configuration. 
# It holds the data required by the domain in order to 
# validate against the input request

# txnHash   	-  stores the transaction units from the configuration
# unitHash  	-  stores the code units from the configuration
# vocabulary	-  stores keys built using txnHash and unitHash

class ConfigObject
	attr_accessor :txnHash
	attr_accessor :unitHash
	attr_accessor :vocabulary
	attr_accessor :metalArray

end