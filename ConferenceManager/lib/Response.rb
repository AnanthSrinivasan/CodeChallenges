# Response class will be filled with below data and sent back to the client. 

# status   		 -  Indicates whether the operation is success or failure
# err-msg  		 -  If the operation is a failure, err_msg will contain 
#             		the reason for the failure
# tracks_array   -  If the operation is a success, tracks array will hold
#             		the arrangement of talks per talks. 

class Response
	attr_accessor :status
	attr_accessor :err_msg
	attr_accessor :object
	attr_accessor :tracks_array

end