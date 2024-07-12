# Advanced Elevator Controller FSM

## Overview

This project implements a Finite State Machine (FSM) for an advanced elevator controller. The FSM handles multiple floor requests, controls the movement of the elevator, and manages the opening and closing of the elevator doors. The system supports 5 floors and includes various features like prioritizing requests, emergency stop, and door control logic.

## Features

- Handles up to 5 floors
- Manages multiple floor requests efficiently
- Controls elevator movement (up, down)
- Manages door opening and closing with timed delays
- Prioritizes requests based on the current direction
- Includes emergency stop functionality
- Provides a comprehensive testbench for simulation

## Files

- `elevator_controller.v`: Verilog module implementing the elevator controller FSM
- `tb_elevator_controller.v`: Testbench for simulating and verifying the elevator controller FSM

## Setup Instructions

1. **Clone the Repository**
    ```bash
    git clone [<project-url>](https://github.com/Aryansh-kr/Elevonic-FSM-Controller)
    cd advanced-elevator-controller
    ```

2. **Open the Project in a Verilog Simulator**
    - Use any Verilog simulator of your choice (e.g., ModelSim, Vivado, Icarus Verilog).
    - Open the `elevator_controller.v` and `tb_elevator_controller.v` files in the simulator.

3. **Compile and Run the Simulation**
    - Compile the `elevator_controller.v` module and the `tb_elevator_controller.v` testbench.
    - Run the simulation to observe the behavior of the elevator controller.

## Module Descriptions

### Elevator Controller FSM (`elevator_controller.v`)

The `elevator_controller` module implements the FSM for controlling the elevator. It handles multiple floor requests and manages the movement and door operations of the elevator.

#### Inputs
- `clk`: Clock signal.
- `reset`: Reset signal.
- `floor_request`: One-hot encoded floor requests (5-bit for 5 floors).

#### Outputs
- `current_floor`: Current floor of the elevator (3-bit).
- `moving_up`: Indicates if the elevator is moving up.
- `moving_down`: Indicates if the elevator is moving down.
- `door_open`: Indicates if the elevator door is open.

#### FSM States
- `IDLE`: Elevator is idle, waiting for requests.
- `MOVING_UP`: Elevator is moving up.
- `MOVING_DOWN`: Elevator is moving down.
- `OPEN_DOOR`: Elevator door is opening.
- `CLOSE_DOOR`: Elevator door is closing.

### Testbench (`tb_elevator_controller.v`)

The `tb_elevator_controller` module is the testbench for simulating and verifying the elevator controller FSM. It includes various test scenarios to ensure the correct behavior of the FSM.

#### Test Scenarios
1. Request Floor 1
2. Request Floor 4
3. Request Ground Floor (Floor 0)
4. Request Middle Floor (Floor 2)
5. Multiple Requests (Floors 0, 2, and 4)

#### Monitor Signals
- Prints the current time, floor, moving status, door status, and floor requests to observe the behavior.

## Simulation Waveform Result
![Sim](https://github.com/Aryansh-kr/CurePolygon/assets/127012188/30319038-8be4-4ae8-a803-5dcc05ce3bb1)



## Usage

1. Modify the `floor_request` signal in the testbench to simulate different scenarios.
2. Observe the output signals (`current_floor`, `moving_up`, `moving_down`, `door_open`) to verify the FSM's behavior.
3. Extend the testbench with additional scenarios to thoroughly test the elevator controller.

## Future Enhancements

- Implement a queue to manage multiple floor requests more efficiently.
- Add a user interface with buttons and indicators for each floor.
- Integrate sensors for door open/close status and emergency stop.
- Optimize the movement logic to minimize travel time.
- Add a maintenance mode for manual control and checks.
- Use formal verification tools to verify the correctness of the FSM.

