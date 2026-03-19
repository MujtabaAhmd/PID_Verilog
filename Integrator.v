module Integrator #(parameter SIZE = 8) (
    input clk,
    input reset,
    input [SIZE-1:0] error_current,
    input [SIZE-1:0] dt,
    output reg [SIZE-1:0] integral
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integral <= 0;
        end else begin
            // Area = error * dt. Accumulate it over time.
            integral <= integral + (error_current * dt);
        end
    end
endmodule