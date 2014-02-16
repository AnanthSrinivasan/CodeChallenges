require "../RequestValidator.rb"
require '../Configuration.rb'

config = Configuration.new
cfgObj = config.getConfig

test = RequestValidator.new 

# input = "pish tegj glob glob"
# puts test.validateRequest input, cfgObj.vocabulary

# input = "glob Silver prok"
# puts test.validateRequest input, cfgObj.vocabulary

input = "glob glob Silver"
puts test.validateRequest input, cfgObj.vocabulary
