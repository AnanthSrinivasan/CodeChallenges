require "../LanguageChecker.rb"

test = LanguageChecker.new
puts test.roman? ('IIII')

puts test.roman? ("II")