require_relative "tracer"
require_relative "table"

class Command
	attr_accessor :instruction, :params, :validation_status

	VALID_COMMAND = 1
	COMMAND_REQUIRES_PARAMS = 0
	INVALID_COMMAND = -1

	PARAMS_OK = 2
	NOT_ENOUGH_PARAMS = -3
	ACCEPTED_WITH_IGNORED_PARAMS = 4
	INVALID_PARAMS_POS_X = -4
	INVALID_PARAMS_POS_Y = -5
	INVALID_PARAMS_POS_DIR = -6

	VALID_COMMANDS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
	VALID_DIRECTIONS = ["NORTH", "SOUTH", "WEST", "EAST"]

	def initialize(input)
		@instruction = input.split(" ").first.to_s
		@validation_status = validate_command(@instruction)

		if (@validation_status == COMMAND_REQUIRES_PARAMS)
			@validation_status = validate_params(input.split(" ").drop(1))
		end
	end

	private

	def validate_command(command)
		return COMMAND_REQUIRES_PARAMS if command == "PLACE"
		return INVALID_COMMAND unless VALID_COMMANDS.include?(command)
		return VALID_COMMAND
	end

	def is_number(param)
		/\A[-+]?\d+\z/ === param
	end

	def validate_params(params)
		case @instruction
			when "PLACE" 
				set_params(params)
				if @params.length < 3
					return NOT_ENOUGH_PARAMS
				elsif @params.length > 3
					return ACCEPTED_WITH_IGNORED_PARAMS
				elsif !(is_number(@params[0]))
					return INVALID_PARAMS_POS_X
				elsif !(Table.instance.isXinHorizontalRange(@params[0].to_i))
					return INVALID_PARAMS_POS_X
				elsif !(is_number(@params[1]))
					return INVALID_PARAMS_POS_Y
				elsif !(Table.instance.isYinVerticalRange(@params[1].to_i))
					return INVALID_PARAMS_POS_Y
				elsif not VALID_DIRECTIONS.include?(@params[2])
					return INVALID_PARAMS_POS_DIR
				else
					return PARAMS_OK
				end
			else
				Tracer.info("Parameters Ignored.")
				return ACCEPTED_WITH_IGNORED_PARAMS
		end
		
		return PARAMS_OK
	end 

	def set_params(params)
		@params = params.join.delete(" ").split(',') 
		Tracer.debug @params.inspect
	end
end