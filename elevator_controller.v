`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aryansh
// 
// Create Date: 29.06.2024 19:28:22
// Design Name: Elevator Controller
// Module Name: elevator_controller
// Project Name: Advanced Elevator Controller
// Target Devices: 
// Tool Versions: 
// Description: 
// This module implements a Finite State Machine (FSM) for an elevator controller
// that manages up to 5 floors, handles multiple requests, prioritizes movements,
// and controls door operations.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module elevator_controller (
    input wire clk,
    input wire reset,
    input wire [4:0] floor_request, // Floor requests (one-hot encoded for 5 floors)
    output reg [2:0] current_floor, // Current floor (3-bit to accommodate 5 floors)
    output reg moving_up, // Elevator moving up
    output reg moving_down, // Elevator moving down
    output reg door_open // Elevator door open
);

    // Parameters for state definitions
    parameter IDLE = 3'b000;
    parameter MOVING_UP = 3'b001;
    parameter MOVING_DOWN = 3'b010;
    parameter OPEN_DOOR = 3'b011;
    parameter CLOSE_DOOR = 3'b100;
    
    reg [2:0] current_state, next_state;
    reg [4:0] request_queue;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            current_floor <= 3'b000;
            moving_up <= 0;
            moving_down <= 0;
            door_open <= 0;
            request_queue <= 5'b00000;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @* begin
        next_state = current_state;
        moving_up = 0;
        moving_down = 0;
        door_open = 0;

        // Combine new requests with existing queue
        request_queue = floor_request | request_queue;
        
        case (current_state)
            IDLE: begin
                if (request_queue[current_floor]) begin
                    next_state = OPEN_DOOR;
                end else if (request_queue > (1 << current_floor)) begin
                    next_state = MOVING_UP;
                    moving_up = 1;
                end else if (request_queue < (1 << current_floor)) begin
                    next_state = MOVING_DOWN;
                    moving_down = 1;
                end
            end
            
            MOVING_UP: begin
                if (current_floor == 3'b100) begin // Reached top floor (Floor 4)
                    next_state = IDLE;
                end else begin
                    current_floor = current_floor + 1;
                    next_state = IDLE;
                end
            end
            
            MOVING_DOWN: begin
                if (current_floor == 3'b000) begin // Reached ground floor (Floor 0)
                    next_state = IDLE;
                end else begin
                    current_floor = current_floor - 1;
                    next_state = IDLE;
                end
            end
            
            OPEN_DOOR: begin
                door_open = 1;
                next_state = CLOSE_DOOR;
            end

            CLOSE_DOOR: begin
                door_open = 0;
                request_queue[current_floor] = 0; // Clear the request for the current floor
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule

