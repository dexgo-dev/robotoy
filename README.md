# RoboToy

Half Robot -  half toy! The application is a simulation of a toy robot moving on a 5 x 5 (default) unit tabletop. It is an example of a well tested, object oriented design, employing the command design and singleton patterns.

## Version

Latest version is documented in [this ruby file](https://github.com/dexterfgo/robotoy/blob/master/lib/RoboToy/version.rb) and SHOULD correspond to the last pushed tag in github.

## Description

* The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

* There are no other obstructions on the table surface.

* The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

Create an application that can read in commands of the following form:
```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

* `PLACE` will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

* The origin (0,0) can be considered to be the SOUTH WEST most corner.

* The first valid command to the robot is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another `PLACE` command. The application should discard all commands in the sequence until a valid `PLACE` command has been executed

* `MOVE` will move the toy robot one unit forward in the direction it is currently facing.

* `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

* `REPORT` will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.

* A robot that is not on the table can choose to ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.

* Input can be from a file, or from standard input, as the developer chooses.

* Provide test data to exercise the application.

### Constraints

* The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.

* Any move that would cause the robot to fall must be ignored.

### Example Input and Output:

#### Example a

    PLACE 0,0,NORTH
    MOVE
    REPORT

Expected output:

    0,1,NORTH

#### Example b

    PLACE 0,0,NORTH
    LEFT
    REPORT

Expected output:

    0,0,WEST

#### Example c

    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT

Expected output

    3,3,NORTH

## Installation

Clone from [RoboToy's GitHub](git@github.com:dexterfgo/robotoy.git)

```
    $ git clone git@github.com:dexterfgo/robotoy.git
```

And then execute:

```
    $ bundle install
```

## Usage

```
    $ cd RoboToy
```

### Production Run

```
    $ ruby lib/RoboToy.rb
```

All end users will use that to run this app. Note: Please make sure there are no parameters.

### Interface

Once this prompt appears, you may enter your commands as in the Description.

```
    COMMAND >>>
```

### Testing

```
    $ bundle exec rspec
```

### Debug Run

```
    $ ruby lib/RoboToy.rb 1
```

Any character added in place of "1" turns on debugging on console. Use this option if you want to do some experimenting with the code.

### Logs

Both debug and production runs produce debug output texts in
```
    $ log/prod
```

for production runs, and 

```
    $ log/debug
```

for debug runs.

## Design Considerations
- Singleton - There must only be one table instantiated.
- Command Pattern - enables us to split parameters and consider each command as separate instances.

## Future Work

- Graphical Interface (we strived for simplicity on this one)
- Add more testcase coverage.


## Contributing

Bug reports and pull requests are welcome on GitHub at [RoboToy Issues Page](https://github.com/dexterfgo/robotoy/issues). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## Credits and Ideas
I had a look at previous work to whip up some inspiration for this and some ideas on how to solve some obstructions I had. Thanks to these githubs:

- [Drzel's Another Toy Robot](https://github.com/drzel/another_toy_robot)
- [Rafael Chefe's Toy Robot](https://github.com/RafaelChefe/toy_robot.git)

## License

This app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

