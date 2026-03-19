module PID_Controller #(
    parameter SIZE = 8,
    // Internal width to prevent overflow (2 * SIZE + 2 bits for safety)
    parameter INT_SIZE = (2 * SIZE) + 2 
)(
    input signed [SIZE-1:0] setpoint, 
    input signed [SIZE-1:0] point, 
    input signed [SIZE-1:0] K_p, 
    input signed [SIZE-1:0] K_d, 
    input signed [SIZE-1:0] K_i,
    input clk, 
    input signed [SIZE-1:0] dt, 
    input reset,
    output signed [SIZE-1:0] u_t
);

    // --- Internal Registers ---
    reg signed [SIZE-1:0] error_c;
    reg signed [SIZE-1:0] error_old;
    reg signed [INT_SIZE-1:0] integral;
    
    // --- Intermediate Calculation Wires ---
    wire signed [INT_SIZE-1:0] p_term;
    wire signed [INT_SIZE-1:0] i_term;
    wire signed [INT_SIZE-1:0] d_term;
    wire signed [INT_SIZE-1:0] full_sum;

    // 1. Error Tracking & Integral Accumulation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            error_c   <= 0;
            error_old <= 0;
            integral  <= 0;
        end else begin
            error_old <= error_c;
            error_c   <= setpoint - point;
            
            // Integral = integral + (error * dt)
            // We use INT_SIZE here to prevent the accumulator from wrapping around
            integral  <= integral + (error_c * dt);
        end
    end

    // 2. Term Calculations (Expanding to INT_SIZE)
    assign p_term = K_p * error_c;
    assign i_term = K_i * integral;
    
    // Derivative: Kd * ((error_c - error_old) / dt)
    // Avoid division by zero with a simple check
    assign d_term = (dt != 0) ? (K_d * (error_c - error_old) / dt) : 0;

    // 3. Final Summation
    assign full_sum = p_term + i_term + d_term;

    // 4. Output Clipping (Saturation Logic)
    // We downsize the result back to [SIZE-1:0], but we "saturate" it
    // so it stays at Max/Min instead of rolling over to a random value.
    assign u_t = (full_sum > {{(INT_SIZE-SIZE){1'b0}}, {(SIZE-1){1'b1}}}) ? {(SIZE-1){1'b1}} : 
                 (full_sum < {{(INT_SIZE-SIZE){1'b1}}, {(SIZE-1){1'b0}}}) ? {(SIZE-1){1'b0}} : 
                 full_sum[SIZE-1:0];

endmodule