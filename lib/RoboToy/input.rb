require_relative "command"
require_relative "tracer"

class Input
	
	attr_accessor :command, :parsing_status

	# Parsing Status Values
	PARSING_INCOMPLETE = 1
	PARSING_OK = 0
	PARSING_FAILED_IN_COMMAND_INST = -1
	PARSING_FAILED_IN_PARAMS = -2

	def initialize(input)
		@parsing_status = PARSING_INCOMPLETE # in case of illegal terminations

		# split the command/instruction bit of the input and the params
		@command = Command.new(input.strip.upcase)

		Tracer.debug "Input.new: command { inst: " + @command.instruction.to_s + \
			", params: " + @command.params.to_s + \
			" validation: " + @command.validation_status.to_s + " }"

		# no need to proceed if the instruction is already invalid				
		@parsing_status = PARSING_FAILED_IN_COMMAND_INST if (@command.validation_status == Command::INVALID_COMMAND)
		@parsing_status = PARSING_FAILED_IN_PARAMS if (@command.validation_status == Command::NOT_ENOUGH_PARAMS)
		@parsing_status = PARSING_FAILED_IN_PARAMS if (@command.validation_status == Command::INVALID_PARAMS_POS_X)
		@parsing_status = PARSING_FAILED_IN_PARAMS if (@command.validation_status == Command::INVALID_PARAMS_POS_Y)
		@parsing_status = PARSING_FAILED_IN_PARAMS if (@command.validation_status == Command::INVALID_PARAMS_POS_DIR)
		@parsing_status = PARSING_FAILED_IN_PARAMS if (@command.validation_status == Command::COMMAND_REQUIRES_PARAMS)

		# Valid inputs > 0. See Command class.
		@parsing_status = PARSING_OK if (@command.validation_status == Command::ACCEPTED_WITH_IGNORED_PARAMS)
		@parsing_status = PARSING_OK if (@command.validation_status == Command::VALID_COMMAND)
		@parsing_status = PARSING_OK if (@command.validation_status == Command::PARAMS_OK)
	end
end