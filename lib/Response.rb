# Response class will be filled with below data 
# and sent back to the client. 

# status   -  Indicates whether the operation is success or failure
# err-msg  -  If the operation is a failure, err_msg will contain 
#             the reason for the failure
# object   -  If the operation is a failure, object will contain 
#             the details of the object which caused the failure.
# clicks   -  If the operation is a success, clicks will hold
#             the minimum clicks took to navigate through the sequence

class Response
	attr_accessor :status
	attr_accessor :err_msg
	attr_accessor :object
	attr_accessor :clicks

	def initialize
		
	end
	
end