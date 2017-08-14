require 'singleton'

class Table
	# attr_reader :width
	# attr_reader :length
	include Singleton

	def initialize(width: 5,length: 5)
		@x_range = Range.new(0,width,false)
		@y_range = Range.new(0,length,false)
		Tracer.debug "x_range: " + @x_range.to_s
		Tracer.debug "y_range: " + @y_range.to_s
	end

	def isXinHorizontalRange(x)
		Tracer.debug "Is " + x.to_s + " in "  + @x_range.to_s + "?"
		Tracer.debug @x_range.cover?(x)
		return @x_range.cover?(x)
	end

	def isYinVerticalRange(y)
		Tracer.debug "Is " + y.to_s + " in "  +  @y_range.to_s + "?"
		Tracer.debug @y_range.cover?(y)
		return @y_range.cover?(y)
	end

	def areCoordinatesInTable(x,y)
		Tracer.debug "areCoordinatesInTable: "
		return (isXinHorizontalRange(x) && isYinVerticalRange(y))
	end

end