require_relative 'table'

class Robot

	attr_reader :x_coordinate # x coordinate in table
	attr_reader :y_coordinate # y coordinate in table
	attr_reader :direction # north, south, east, west

	def place(x,y,dir)
		if (validate_coordinates(x,y)) && (validate_direction(dir))
			@x_coordinate = x
			@y_coordinate = y
			@direction = dir
		end
	end

	private

	def validate_coordinates(x,y)
		return Table.new.areCoordinatesInTable(x,y)
	end

	def validate_direction(dir)
		return ["NORTH", "SOUTH", "WEST", "EAST"].include?(dir)
	end
end