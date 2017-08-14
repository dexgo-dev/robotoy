require_relative "RoboToy/version"
require_relative "RoboToy/input"
require_relative "RoboToy/robot"
require_relative "RoboToy/tracer"
require_relative "RoboToy/table"

module RoboToy
	def self.main()

		# Use an argument to specify debug run
		# ruby RoboToy.rb "anything" for Debug
		# ruby RoboToy.rb for prod
		Tracer.create(!ARGV.empty?)
		Tracer.info "RoboToy v" + RoboToy::VERSION + " Begin Simulation...\n"

		robot = Robot.new()

		# Endlessly request for input unless an exit is requested
		loop do
			begin
				Tracer.flash "COMMAND >> "
		    	terminal = STDIN.gets
			rescue Interrupt
				terminal = "exit"
				break
			end
		    # If exit is typed, end simulation.
		    break if terminal =~ /^\s*exit\s+/    

		    # Not "exit"? Parse input.
		    input = Input.new(terminal)
		    # command = Command.new(terminal.strip.upcase)

		    # If it failed, say why
		    case input.parsing_status
		    	when Input::PARSING_INCOMPLETE then Tracer.warn "Parse did not complete."
		    	when Input::PARSING_FAILED_IN_COMMAND_INST then Tracer.warn "Bad Command: (" + input.command.instruction + "\)"
		    	when Input::PARSING_FAILED_IN_PARAMS then Tracer.warn "Bad Parameters: (" + input.command.params.inspect.to_s + "\)"
		    end
		    
		    if input.parsing_status == Input::PARSING_OK
		    	Tracer.debug "Command: " + input.command.instruction.to_s + " Parameters: " + input.command.params.inspect.to_s + "\n"
		    end

		    robot.execute(input.command)
		end # loop

		Tracer.info "\nEnd Simulation."
	end # self.main
end # module RoboToy

# Run This When we do "ruby RoboToy.rb"
RoboToy.main() unless $TESTING == true #spec_helper.rb
