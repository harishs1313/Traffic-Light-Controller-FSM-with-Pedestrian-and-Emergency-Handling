`timescale 1ns / 1ps
module TrafficLightController (
    input clk,
    input reset,
    input pedestrian_req,
    input emergency,
    output reg red,
    output reg yellow,
    output reg green,
    output reg ped_red,
    output reg ped_green
);

// State encoding
parameter RED = 0, RED_YELLOW = 1, GREEN = 2, YELLOW = 3,
          PED_GREEN = 4, EMERGENCY_GREEN = 5;

reg [2:0] state, next_state;
reg [3:0] timer;  // For delays

// FSM State Transition and Timer update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= RED;
        timer <= 0;
    end else begin
        state <= next_state;
        if (timer > 0)
            timer <= timer - 1;
    end
end

// Next state logic
always @(*) begin
    case(state)
        RED: begin
            if (emergency)
                next_state = EMERGENCY_GREEN;
            else if (timer == 0)
                next_state = RED_YELLOW;
            else
                next_state = RED;
        end

        RED_YELLOW: begin
            if (timer == 0)
                next_state = GREEN;
            else
                next_state = RED_YELLOW;
        end

        GREEN: begin
            if (emergency)
                next_state = EMERGENCY_GREEN;
            else if (timer == 0)
                next_state = YELLOW;
            else
                next_state = GREEN;
        end

        YELLOW: begin
            if (pedestrian_req)
                next_state = PED_GREEN;
            else if (timer == 0)
                next_state = RED;
            else
                next_state = YELLOW;
        end

        PED_GREEN: begin
            if (timer == 0)
                next_state = RED;
            else
                next_state = PED_GREEN;
        end

        EMERGENCY_GREEN: begin
            if (timer == 0)
                next_state = YELLOW;
            else
                next_state = EMERGENCY_GREEN;
        end

        default: next_state = RED;
    endcase
end

    // Output logic and timer load on state entry
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            red <= 1;
            yellow <= 0;
            green <= 0;
            ped_red <= 1;
            ped_green <= 0;
            timer <= 4;
        end else begin
            case (state)
                RED: begin
                    red <= 1;
                    yellow <= 0;
                    green <= 0;
                    ped_red <= 1;
                    ped_green <= 0;
                    if (timer == 0)
                        timer <= 4;
                end

                RED_YELLOW: begin
                    red <= 1;
                    yellow <= 1;
                    green <= 0;
                    ped_red <= 1;
                    ped_green <= 0;
                    if (timer == 0)
                        timer <= 2;
                end

                GREEN: begin
                    red <= 0;
                    yellow <= 0;
                    green <= 1;
                    ped_red <= 1;
                    ped_green <= 0;
                    if (timer == 0)
                        timer <= 5;
                end

                YELLOW: begin
                    red <= 0;
                    yellow <= 1;
                    green <= 0;
                    ped_red <= 1;
                    ped_green <= 0;
                    if (timer == 0)
                        timer <= 3;
                end

                PED_GREEN: begin
                    red <= 1; // Keep cars at red
                    yellow <= 0;
                    green <= 0;
                    ped_red <= 0;
                    ped_green <= 1;
                    if (timer == 0)
                        timer <= 6; // Increased timer for pedestrian green
                end

                EMERGENCY_GREEN: begin
                    red <= 0;
                    yellow <= 0;
                    green <= 1; // Green for cars
                    ped_red <= 1;
                    ped_green <= 0;
                    if (timer == 0)
                        timer <= 6;
                end

                default: begin
                    red <= 1;
                    yellow <= 0;
                    green <= 0;
                    ped_red <= 1;
                    ped_green <= 0;
                    timer <= 4;
                end
            endcase
        end
    end

endmodule
