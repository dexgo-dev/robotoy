class Table
	attr_reader :width
	attr_reader :length

	def initialize(width = 5,length = 5) # We can customize the table size
		@width = width
		@length = length
	end
	def areCoordinatesInTable(x,y)
		return x.between?(0,@width) && y.between?(0,@length)
	end
end