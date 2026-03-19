module PID_Controller #(parameter SIZE = 8) (
	input [SIZE-1:0] setpoint, 
	input [SIZE-1:0] point, 
	input [SIZE-1:0] K_p, 
	input [SIZE-1:0] K_d, 
	input [SIZE-1:0] K_i,
	input clk, 
	input dt,
	input reset,
	output [SIZE-1:0] u_t
	);

always @ (posedge clk or posedge reset) begin

	reg [SIZE-1:0] error_c;
	reg [SIZE-1:0] error_old;
	reg [SIZE-1:0] deri
	
	ErrorTracker #(.SIZE(SIZE)) errorcal (.clk(clk), .reset(reset), .setpoint(setpoint), .(point)point, .current_error(error_c), .old_error(error_old));
	Derivative #(.SIZE(SIZE)) deriva (.error_current(error_c), .error_old(error_old), .dt(dt), .d(deri));
end
endmodule