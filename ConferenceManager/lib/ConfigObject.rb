# ConfigObject will be the middle man used both by the
# domain as well as the input configuration. 

# talks_data   		-  stores the talks information from the configuration
# sessions_data   	-  stores the sessions information from the configuration

class ConfigObject
	attr_accessor :talks_data
	attr_accessor :sessions_data
end