require "spec_helper"

RSpec.describe RoboToy do
  it "has a version number" do
    expect(RoboToy::VERSION).not_to be nil
  end

  describe "#main" do
  	before (:each) do
  	  @robot_test = instance_double ("Robot")
    end

    it "creates a new instance of Robot" do
      expect(Robot).to receive(:new) { @robot_test }
      allow(STDIN).to receive(:gets).and_return "right\n","exit\n"
      expect(@robot_test).to receive(:execute)
      RoboToy.main
    end

    it "creates a new instance of Input" do
      allow(Robot).to receive(:new) { @robot_test }
      allow(STDIN).to receive(:gets).and_return "lEfT\n", "exit\n"
      input_test  = instance_double("Input")
      expect(Input).to receive(:new).with("lEfT\n") { input_test }
      expect(input_test).to receive(:parsing_status).at_least(:once)
      expect(input_test).to receive(:command)
      expect(@robot_test).to receive(:execute)
      RoboToy.main
    end
  end
end
