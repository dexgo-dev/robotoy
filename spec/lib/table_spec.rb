require "spec_helper"
require "RoboToy/table"

describe Table do
	TEST_X = 7
	TEST_Y = 7
	before (:each) do
		Table.instance.setup(TEST_X, TEST_Y)
	end

	it "allows setup() to set bounds." do
		expect(Table.instance.areCoordinatesInTable(TEST_X,TEST_Y)).to be(true)
		expect{ Table.instance.setup(6,6) }.to \
			change { [Table.instance.x_range, Table.instance.y_range] }
		expect(Table.instance.areCoordinatesInTable(TEST_X,TEST_Y)).to be(false)
	end

	it "is able to tell if coordinates are not within bounds." do		
		expect(Table.instance.areCoordinatesInTable(9,5)).to be(false)
		expect(Table.instance.areCoordinatesInTable(-1,4)).to be(false)
		expect(Table.instance.areCoordinatesInTable(8,8)).to be(false)
	end

	it "is able to tell if coordinates are within bounds." do		
		expect(Table.instance.areCoordinatesInTable(TEST_X,TEST_Y)).to be(true) # corner
		expect(Table.instance.areCoordinatesInTable(0,0)).to be(true) #corner
		expect(Table.instance.areCoordinatesInTable(3,1)).to be(true)
	end
end