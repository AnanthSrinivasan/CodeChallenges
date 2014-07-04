class Session
	attr_accessor :type, :talks

	def initialize
		@talks = []
	end
	
	def add_talk(talk)
		@talks.push(talk) if !full?
	end

	def full?
				
	end

end