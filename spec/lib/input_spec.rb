require "spec_helper"
require "RoboToy/input"

describe Input do

	it "returns " + Input::PARSING_FAILED_IN_COMMAND_INST.to_s + " when input has invalid command. Input: Lift" do		
		@input_test = Input.new("Lift")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_COMMAND_INST)
	end

	it "returns " + Input::PARSING_FAILED_IN_COMMAND_INST.to_s + " when input has invalid command. Input: JUMP 1,2,EAST" do		
		@input_test = Input.new("JUMP 1,2,EAST")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_COMMAND_INST)
	end

	it "returns " + Input::PARSING_FAILED_IN_PARAMS.to_s + " when input has no params. Input: PLACE" do		
		@input_test = Input.new("PLACE 1")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_PARAMS)
	end

	it "returns " + Input::PARSING_FAILED_IN_PARAMS.to_s + " when input has not enough params. Input: PLACE 1,EAST" do		
		@input_test = Input.new("PLACE 1,EAST")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_PARAMS)
	end

	it "returns " + Input::PARSING_FAILED_IN_PARAMS.to_s + " when parameters are invalid. Input: PLACE 1,4,5" do		
		@input_test = Input.new("PLACE 1,4,5")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_PARAMS)
	end

	it "returns " + Input::PARSING_FAILED_IN_PARAMS.to_s + " when parameters are in invalid order. Input: PLACE 4,EAST,5" do		
		@input_test = Input.new("PLACE 4,EAST,5")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_PARAMS)
	end

	it "returns " + Input::PARSING_FAILED_IN_PARAMS.to_s + " when parameters are in invalid order. Input: PLACE EAST,4,5" do		
		@input_test = Input.new("PLACE EAST,4,5")
		expect(@input_test.parsing_status).to eq(Input::PARSING_FAILED_IN_PARAMS)
	end

	it "returns " + Input::PARSING_OK.to_s + " when input is valid in any case. Input: left" do		
		@input_test = Input.new("left")
		expect(@input_test.parsing_status).to eq(Input::PARSING_OK)
	end

	it "returns " + Input::PARSING_OK.to_s + " when input is valid but cases gone weird. Input: riGht" do		
		@input_test = Input.new("riGht")
		expect(@input_test.parsing_status).to eq(Input::PARSING_OK)
	end

	it "returns " + Input::PARSING_OK.to_s + " when input is valid in lower case. Input: place 1,2,west" do		
		@input_test = Input.new("place 1,2,west")
		expect(@input_test.parsing_status).to eq(Input::PARSING_OK)
	end

	it "returns " + Input::PARSING_OK.to_s + " when input is valid in any case. Input: REPORT" do		
		@input_test = Input.new("REPORT")
		expect(@input_test.parsing_status).to eq(Input::PARSING_OK)
	end

	it "returns " + Input::PARSING_OK.to_s + " when input is valid but with extra params not needed. Input: Place 1,2,south,west" do		
		@input_test = Input.new("Place 1,2,south,west")
		expect(@input_test.parsing_status).to eq(Input::PARSING_OK)
	end
end