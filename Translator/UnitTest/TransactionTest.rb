require "../Transaction.rb"
require "../Response.rb"

# Initialize objects for Testing
response = Response.new
response.status = Status::FAILURE
response.err_msg = ErrorMsg::UNDEFINED

input = "glob glob Silver"
test = Transaction.new

# 1. Config Validation Test
# Add some invalid roman in the input.txt
# Check we are failing with Invalid Configuration

# ================================================

# 2. Config Language Test
# Remove either code or transaction measure in input
# Check we are failing with Missing Configuration

puts "Config Language Test"
input = "glob glob Silver"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "================================================"

# ================================================

# 3. Invalid Key Test
# Add some invalid keys in the input
# Check we are failing with Unrecognized Language

puts "Invalid Key Test"
input = "glob glob Silverr"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "================================================"

# ================================================

# 4. No Metal in Input Test
# Add metal in invalid position in the input
# Check we are failing with Invalid Metal Position

puts "No Metal in Input Test"
input = "pish tegj glob glob"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "#{input} is #{output.credits} Credits"
puts "================================================"

# ================================================

# 4. Invalid Metal Position Test
# Add metal in invalid position in the input
# Check we are failing with Invalid Metal Position

puts "Invalid Metal Position Test"
input = "glob Silver glob"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "================================================"

# ================================================

# 5. Invalid Roman Formation Test
# Add some invalid keys in the input
# Check we are failing with Unrecognized Language

puts "Invalid Roman Formation Test"
input = "glob glob glob glob Silver"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "================================================"

# ================================================

# 6. Successful Transaction Test
# Remove either code or transaction measure in input
# Check we are failing with Missing Configuration

puts "Successful Transaction Test"
input = "glob glob Silver"
output = test.getCredits(input, response)

puts "Input : #{input}"
puts "Status : #{output.status}"
puts "Reason : #{output.err_msg}"
puts "#{input} is #{output.credits} Credits"
puts "================================================"

# ================================================

