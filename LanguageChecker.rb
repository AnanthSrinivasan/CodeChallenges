
# Validates the input against the given language
# For now roman is the only language we validate

# If we start talking in numerals or any other
# language, we can add the validation for it here.

class LanguageChecker

	def roman? input
		!(input.scan(/^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/).empty?)
	end
	
end

# For now let's leave the discretion of handling
# invalid roman with the clients.  Reason being
# roman input might be invalid either from request
# or from the configuration itself..