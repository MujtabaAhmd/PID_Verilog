// --- Derivative Module ---
module Derivative #(parameter SIZE = 8) (
    input [SIZE-1:0] error_current, 
    input [SIZE-1:0] error_old, 
    input [SIZE-1:0] dt, 
    output [SIZE-1:0] d
);
    // Simple derivative: (de/dt). 
    // Note: Division is expensive in hardware; often dt is assumed to be 1 
    // or handled via scaling. Here we follow your logic:
    assign d = error_current - error_old;

endmodule