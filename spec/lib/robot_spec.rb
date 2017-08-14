require "spec_helper"
require "RoboToy/robot"

describe Robot do
	before (:each) do
		@robot_test = Robot.new
	end 

	it "is a Robot." do
		expect(@robot_test).to be_a(Robot)
	end

	it "has not yet been placed on the table." do
		
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will execute scenario example 1 on exercise" do
		expect{ @robot_test.place 0,0,"NORTH"
				@robot_test.move
				@robot_test.report }.to \
				output("0,1,NORTH\n").to_stdout
	end

	it "will execute scenario example 2 on exercise" do
		expect{ @robot_test.place 0,0,"NORTH"
				@robot_test.left
				@robot_test.report }.to \
				output("0,0,WEST\n").to_stdout
	end

	it "will execute scenario example 3 on exercise" do
		expect{ @robot_test.place 1,2,"EAST"
				@robot_test.move
				@robot_test.move
				@robot_test.left
				@robot_test.move
				@robot_test.report }.to \
				output("3,3,NORTH\n").to_stdout_from_any_process
	end

	it "can be placed to change position and direction if new position AND direction are all valid. " do
		expect{ @robot_test.place 1,4,"SOUTH" }.to \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(1)
		expect(@robot_test.y_coordinate).to eq(4)
		expect(@robot_test.direction).to eq("SOUTH")

		# corner
		expect{ @robot_test.place 0,0,"EAST" }.to \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(0)
		expect(@robot_test.y_coordinate).to eq(0)
		expect(@robot_test.direction).to eq("EAST")

		# corner
		expect{ @robot_test.place 0,5,"NORTH" }.to \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(0)
		expect(@robot_test.y_coordinate).to eq(5)
		expect(@robot_test.direction).to eq("NORTH")

		# corner
		expect{ @robot_test.place 5,0,"WEST" }.to \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(5)
		expect(@robot_test.y_coordinate).to eq(0)
		expect(@robot_test.direction).to eq("WEST")

		# corner
		expect{ @robot_test.place 5,5,"EAST" }.to \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(5)
		expect(@robot_test.y_coordinate).to eq(5)
		expect(@robot_test.direction).to eq("EAST")
	end

	it "will not place if new position is invalid. " do
		expect{ @robot_test.place 1,6,"SOUTH" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)

		expect{ @robot_test.place -1,2,"NORTH" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)

		expect{ @robot_test.place 6,0,"WEST" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will not place if direction is invalid. " do
		expect{ @robot_test.place 1,3,"DOWN" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)

		expect{ @robot_test.place 0,0,"UP" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)

		expect{ @robot_test.place 2,3,"West" }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will move after being placed but no output." do
		expect{ @robot_test.place 4,2,"WEST"
				@robot_test.move
				@robot_test.move }.to_not output.to_stdout
		expect(@robot_test.x_coordinate).to eq(2)
		expect(@robot_test.y_coordinate).to eq(2)
		expect(@robot_test.direction).to eq("WEST")
	end

	it "will not move if not yet placed." do
		expect{ @robot_test.move }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will not turn right not yet placed." do
		expect{ @robot_test.right }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will not turn left if not yet placed." do
		expect{ @robot_test.left }.to_not \
			change { [@robot_test.x_coordinate, @robot_test.y_coordinate, @robot_test.direction] }
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end

	it "will turn left after being placed." do
		expect{ @robot_test.place 4,2,"WEST"
				@robot_test.left
				@robot_test.move 
				@robot_test.report }.to output("4,1,SOUTH\n").to_stdout
	end

	it "will turn right after being placed." do
		expect{ @robot_test.place 4,2,"WEST"
				@robot_test.right
				@robot_test.move 
				@robot_test.report }.to output("4,3,NORTH\n").to_stdout
	end

	it "will report nothing if not placed." do
		expect{ @robot_test.report }.to_not output.to_stdout 
		expect(@robot_test.x_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.y_coordinate).to eq(Robot::COORD_NOT_ON_TABLE)
		expect(@robot_test.direction).to eq(Robot::DIRECTION_NOT_DEFINED)
	end
end