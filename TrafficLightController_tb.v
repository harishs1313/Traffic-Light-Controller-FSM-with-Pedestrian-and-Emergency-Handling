`timescale 1ns/1ps

module TrafficLightController_tb;

reg clk, reset;
reg pedestrian_req;
reg emergency;
wire red, yellow, green;
wire ped_red, ped_green;

TrafficLightController dut (
    .clk(clk),
    .reset(reset),
    .pedestrian_req(pedestrian_req),
    .emergency(emergency),
    .red(red),
    .yellow(yellow),
    .green(green),
    .ped_red(ped_red),
    .ped_green(ped_green)
);

initial clk = 0;
always #5 clk = ~clk; // 10ns clock

initial begin
    $dumpfile("TrafficLightController.vcd");
    $dumpvars(0, TrafficLightController_tb);

    reset = 1; #10;
    reset = 0;

    pedestrian_req = 0;
    emergency = 0;

    #50 pedestrian_req = 1; // Request pedestrian crossing
    #100 pedestrian_req = 0;

    #50 emergency = 1; // Emergency vehicle
    #30 emergency = 0;

    #400 $finish; // Run long enough to see state transitions
end

initial begin
    $monitor("At time %t: red=%b, yellow=%b, green=%b, ped_red=%b, ped_green=%b, pedestrian_req=%b, emergency=%b",
             $time, red, yellow, green, ped_red, ped_green, pedestrian_req, emergency);
end

endmodule
