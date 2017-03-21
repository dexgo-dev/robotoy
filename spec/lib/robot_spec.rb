require "spec_helper"
require "RoboToy/robot"

describe Robot do
	before (:each) do
		@robot = Robot.new
	end 

	it "is a Robot." do
		expect(@robot).to be_a(Robot)
	end

	it "has not yet been placed on the table." do
		
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil
	end

	it "can be placed to change position and direction if new position AND direction are all valid. " do
		expect{ @robot.place 1,4,"SOUTH" }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(1)
		expect(@robot.y_coordinate).to eq(4)
		expect(@robot.direction).to eq("SOUTH")

		# corner
		expect{ @robot.place 0,0,"EAST" }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(0)
		expect(@robot.y_coordinate).to eq(0)
		expect(@robot.direction).to eq("EAST")

		# corner
		expect{ @robot.place 0,5,"NORTH" }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(0)
		expect(@robot.y_coordinate).to eq(5)
		expect(@robot.direction).to eq("NORTH")

		# corner
		expect{ @robot.place 5,0,"WEST" }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(5)
		expect(@robot.y_coordinate).to eq(0)
		expect(@robot.direction).to eq("WEST")

		# corner
		expect{ @robot.place 5,5,"EAST" }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(5)
		expect(@robot.y_coordinate).to eq(5)
		expect(@robot.direction).to eq("EAST")
	end

	it "will not place if new position is invalid. " do
		expect{ @robot.place 1,6,"SOUTH" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place -1,2,"NORTH" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place 6,0,"WEST" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil
	end

	it "will not place if direction is invalid. " do
		expect{ @robot.place 1,3,"DOWN" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place 0,0,"UP" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place 2,3,"West" }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil
	end

end