require_relative "table"
require_relative "command"
require_relative "tracer"

class Robot

	attr_reader :x_coordinate # x coordinate in table
	attr_reader :y_coordinate # y coordinate in table
	attr_reader :direction # north, south, east, west

	COORD_NOT_ON_TABLE = -1
	DIRECTION_NOT_DEFINED = ""

	def initialize
		@x_coordinate = COORD_NOT_ON_TABLE
		@y_coordinate = COORD_NOT_ON_TABLE
		@direction = DIRECTION_NOT_DEFINED
	end

	def execute(command)
		if (["PLACE"].include?(command.instruction))
			place(command.params[0].to_i, command.params[1].to_i, command.params[2].to_s)
		else
			case command.instruction
				when "MOVE" then move()
				when "LEFT" then left()
				when "RIGHT" then right()
				when "REPORT" then report()
			end
		end
	end

	def place(x,y,dir)
		if (validate_coordinates(x,y)) && (validate_direction(dir))
			@x_coordinate = x
			@y_coordinate = y
			@direction = dir
		else
			Tracer.warn "Command Ignored."
		end
	end

	def left
		if has_been_placed
			last_direction = @direction
			case last_direction
				when "NORTH" then @direction = "WEST"
				when "WEST" then @direction = "SOUTH"
				when "SOUTH" then @direction = "EAST"
				when "EAST" then @direction = "NORTH"
			end
		end
	end

	def right
		if has_been_placed
			last_direction = @direction
			case last_direction
				when "NORTH" then @direction = "EAST"
				when "EAST" then @direction = "SOUTH"
				when "SOUTH" then @direction = "WEST"
				when "WEST" then @direction = "NORTH"
			end
		end
	end

	def move
		if has_been_placed
			target_x = @x_coordinate
			target_y = @y_coordinate
			case @direction
				when "NORTH" then target_y += 1
				when "EAST" then target_x += 1
				when "SOUTH" then target_y -= 1
				when "WEST" then target_x -= 1
			end

			place(target_x,target_y,@direction)
		end
	end

	def report
		Tracer.flash @x_coordinate.to_s + "," + @y_coordinate.to_s + "," + @direction.to_s + "\n" if has_been_placed
	end

	def has_been_placed
		if ((@x_coordinate != COORD_NOT_ON_TABLE) && (@y_coordinate != COORD_NOT_ON_TABLE) && (@direction != DIRECTION_NOT_DEFINED))
			@has_been_placed = true
		else
			@has_been_placed = false
			Tracer.warn "Command Ignored."
		end
	end

	def validate_coordinates(x,y)
		return Table.instance.areCoordinatesInTable(x,y)
	end

	def validate_direction(dir)
		return Command::VALID_DIRECTIONS.include?(dir)
	end
end