module ErrorTracker #(parameter SIZE = 8) (
    input clk,
    input reset,
    input [SIZE-1:0] setpoint,
    input [SIZE-1:0] point,
    output reg [SIZE-1:0] current_error,
    output reg [SIZE-1:0] old_error
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_error <= 0;
            old_error     <= 0;
        end else begin
            old_error     <= current_error;
            current_error <= setpoint - point;
        end
    end
endmodule