require 'singleton'

class Table
	attr_reader :x_range
	attr_reader :y_range
	include Singleton

	def setup(width,length)
		@x_range = Range.new(0,width,false)
		@y_range = Range.new(0,length,false)
		Tracer.debug "x_range: " + @x_range.to_s
		Tracer.debug "y_range: " + @y_range.to_s
	end

	def initialize(width: 5,length: 5)
		Tracer.debug "x_range: " + @x_range.to_s
		Tracer.debug "y_range: " + @y_range.to_s
		@x_range = Range.new(0,width,false) if @x_range.nil?
		@y_range = Range.new(0,length,false) if @y_range.nil?
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