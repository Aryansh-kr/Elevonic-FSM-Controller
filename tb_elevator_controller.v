`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2024 19:31:53
// Design Name: 
// Module Name: tb_elevator_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module tb_elevator_controller;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg reset;
    reg [4:0] floor_request;
    wire [2:0] current_floor;
    wire moving_up;
    wire moving_down;
    wire door_open;

    // Instantiate the module under test
    elevator_controller dut (
        .clk(clk),
        .reset(reset),
        .floor_request(floor_request),
        .current_floor(current_floor),
        .moving_up(moving_up),
        .moving_down(moving_down),
        .door_open(door_open)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Initial reset and floor requests
    initial begin
        clk = 0;
        reset = 1;
        floor_request = 0;

        // Reset for a few clock cycles
        #20 reset = 0;

        // Test scenario 1: Request elevator to move up to floor 3
        #10 floor_request = 5'b00100; // Request to go to floor 3

        // Test scenario 2: Request elevator to move down to ground floor
        #50 floor_request = 5'b00001; // Request to go to ground floor

        // Test scenario 3: Multiple requests (up and then down)
        #80 floor_request = 5'b10010; // Requests to go to floor 1, then floor 4

        // Add more test scenarios as needed

        #100 $finish; // Finish simulation after 100 ns
    end

    // Display statements for observing signals (optional)
    initial begin
        $monitor("Time=%0t clk=%b reset=%b floor_request=%b current_floor=%b moving_up=%b moving_down=%b door_open=%b",
                 $time, clk, reset, floor_request, current_floor, moving_up, moving_down, door_open);
    end

endmodule

