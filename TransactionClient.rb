require "./Transaction.rb"
require "./Response.rb"
require "./Constants.rb"

# Initialize objects for Testing
response = Response.new
response.status = Status::FAILURE
response.err_msg = ErrorMsg::UNDEFINED

txn = Transaction.new

loop do 
	#Get the Transaction Question 
	puts 'Enter the Transaction :'
	question = gets.strip
	question.slice!(/\?/)	#removes ? from the input

	# Removes how many/how much credits and takes units only
	input = question.sub(/^.*\sis\s/, "").strip

	# Get credits and display
	output = txn.getCredits(input, response)

	puts "Input : #{input}"
	puts "Status : #{output.status}"
	puts "Reason : #{output.err_msg}"
	puts "#{input} is #{output.credits} Credits" if output.status == "success"
	puts "================================================"

	puts "Continue? Press N to stop :"
	repeat = gets.strip
	
	break if repeat == 'N'
end 

