require "spec_helper"
require "RoboToy/robot"

describe Robot do
	robot = Robot.new
	
	it "is a Robot." do
		expect(robot).to be_a(Robot)
	end

	it "has not yet been placed on the table." do
		expect(robot.x_coordinate).to be_nil
		expect(robot.y_coordinate).to be_nil
		expect(robot.direction).to be_nil
	end

end