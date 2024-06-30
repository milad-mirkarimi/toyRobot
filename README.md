# ToyRobot

ToyRobot is a simple application written in Ruby that simulates a toy robot moving on a square tabletop.

Ruby v3.2.2

## Features

- Place the robot on the tabletop
- Move the robot forward in the direction it is currently facing
- Rotate the robot left or right
- Report the robot's current position and direction

## Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/yourusername/toyRobot.git
    ```

2. Navigate to the project directory:

    ```sh
    cd toyRobot
    ```

3. Install the required gems:

    ```sh
    bundle install
    ```

## Usage

Run the application using the following command:

```sh
ruby bin/toy_robot
```

## Integration Tests
Run the following command to run the sample test cases from the root of the project

```sh
rspec ./spec/toy_robot_integration_spec.rb
```
or

```sh
rspec bundle exec rspec ./spec/toy_robot_integration_spec.rb
```