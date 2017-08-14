require "spec_helper"
require "RoboToy/command"

describe Command do

	it "returns " + Command::INVALID_COMMAND.to_s + " when command has invalid command. Command: Lift" do		
		@command_test = Command.new("Lift")
		expect(@command_test.validation_status).to eq(Command::INVALID_COMMAND)
	end

	it "returns " + Command::INVALID_COMMAND.to_s + " when command has invalid command. Command: JUMP 1,2,EAST" do		
		@command_test = Command.new("JUMP 1,2,EAST")
		expect(@command_test.validation_status).to eq(Command::INVALID_COMMAND)
	end

	it "returns " + Command::NOT_ENOUGH_PARAMS.to_s + " when command has no params. Command: PLACE" do		
		@command_test = Command.new("PLACE 1")
		expect(@command_test.validation_status).to eq(Command::NOT_ENOUGH_PARAMS)
	end

	it "returns " + Command::NOT_ENOUGH_PARAMS.to_s + " when command has not enough params. Command: PLACE 1,EAST" do		
		@command_test = Command.new("PLACE 1,EAST")
		expect(@command_test.validation_status).to eq(Command::NOT_ENOUGH_PARAMS)
	end

	it "returns " + Command::INVALID_PARAMS_POS_DIR.to_s + " when direction parameter is invalid. Command: PLACE 1,4,5" do		
		@command_test = Command.new("PLACE 1,4,5")
		expect(@command_test.validation_status).to eq(Command::INVALID_PARAMS_POS_DIR)
	end

	it "returns " + Command::INVALID_PARAMS_POS_X.to_s + " when x-coordinate parameter is invalid. Command: PLACE yay,4,SOUTH" do		
		@command_test = Command.new("PLACE yay,4,SOUTH")
		expect(@command_test.validation_status).to eq(Command::INVALID_PARAMS_POS_X)
	end

	it "returns " + Command::INVALID_PARAMS_POS_Y.to_s + " when  y-coordinate parameter is in invalid. Command: PLACE 4,nope,EAST" do		
		@command_test = Command.new("PLACE 4,nope,EAST")
		expect(@command_test.validation_status).to eq(Command::INVALID_PARAMS_POS_Y)
	end

	it "returns " + Command::ACCEPTED_WITH_IGNORED_PARAMS.to_s + " when there are more than the required number of parameters but the head is valid. Command: PLACE 4,5,EAST,NORTH" do		
		@command_test = Command.new("PLACE 4,5,EAST,NORTH")
		expect(@command_test.validation_status).to eq(Command::ACCEPTED_WITH_IGNORED_PARAMS)
	end

	# Note that upper case and lower case processing is done in command class. So they should all be uppercase this time.
	it "returns " + Command::INVALID_COMMAND.to_s + " when valid command is not yet in upper case. Command: left" do		
		@command_test = Command.new("left")
		expect(@command_test.validation_status).to eq(Command::INVALID_COMMAND)
	end

	it "returns " + Command::VALID_COMMAND.to_s + " when command is valid. Command: RIGHT" do		
		@command_test = Command.new("RIGHT")
		expect(@command_test.validation_status).to eq(Command::VALID_COMMAND)
	end

	it "returns " + Command::PARAMS_OK.to_s + " when command is valid with correct parameters but with extra spaces. Spaces should not matter. Command: PLACE 1, 2, WEST" do		
		@command_test = Command.new("PLACE 1, 2, WEST")
		expect(@command_test.validation_status).to eq(Command::PARAMS_OK)
	end

	it "returns " + Command::INVALID_PARAMS_POS_DIR.to_s + " when params is valid but command in wrong case. Command: PLACE 1, 2, weSt" do		
		@command_test = Command.new("PLACE 1, 2, weSt")
		expect(@command_test.validation_status).to eq(Command::INVALID_PARAMS_POS_DIR)
	end

	it "returns " + Command::INVALID_COMMAND.to_s + " when command is valid with extra spaces and required parameters. Command: place 1, 2, WEST" do		
		@command_test = Command.new("place 1, 2, WEST")
		expect(@command_test.validation_status).to eq(Command::INVALID_COMMAND)
	end
end