require_relative "./User.rb"
require_relative "./Response.rb"
require_relative "./Constants.rb"

# Initialize response objects
response = Response.new
response.status = Status::FAILURE
response.err_msg = ErrorMsg::UNDEFINED

user = User.new
setupResponse = user.setupTV('TextFiles/Input.txt')
puts setupResponse.err_msg

if setupResponse.status == "success"
	navigationResponse = user.navigateSequence
	puts "Status : #{navigationResponse.status}"
	puts "Reason : #{navigationResponse.err_msg}"
	if navigationResponse.status == "success"
		puts "Min clicks to navigate is : #{navigationResponse.clicks}" 
	end
	puts "================================================"
end	
