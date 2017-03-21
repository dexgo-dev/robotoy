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

	it "can be placed to change position and direction if new position is valid. " do
		expect{ @robot.place 1,4,2 }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(1)
		expect(@robot.y_coordinate).to eq(4)
		expect(@robot.direction).to eq(2)

		# corner
		expect{ @robot.place 0,0,2 }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(0)
		expect(@robot.y_coordinate).to eq(0)
		expect(@robot.direction).to eq(2)

		# corner
		expect{ @robot.place 0,5,2 }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(0)
		expect(@robot.y_coordinate).to eq(5)
		expect(@robot.direction).to eq(2)

		# corner
		expect{ @robot.place 5,0,2 }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(5)
		expect(@robot.y_coordinate).to eq(0)
		expect(@robot.direction).to eq(2)

		# corner
		expect{ @robot.place 5,5,2 }.to \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to eq(5)
		expect(@robot.y_coordinate).to eq(5)
		expect(@robot.direction).to eq(2)
	end

	it "will not place if new position is invalid. " do
		expect{ @robot.place 1,6,2 }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place -1,2,2 }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil

		expect{ @robot.place 6,0,2 }.to_not \
			change { [@robot.x_coordinate, @robot.y_coordinate, @robot.direction] }
		expect(@robot.x_coordinate).to be_nil
		expect(@robot.y_coordinate).to be_nil
		expect(@robot.direction).to be_nil
	end

end