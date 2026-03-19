# PID_Verilog
Verilog implementation of PID Controller

The code is in its initial stages and optimization of is to be done.

It implments simple PID controller in the top level module
### Inputs
- setpoint [K bits]
- point (current point) [K bits]
- K_p (proportational gain) [K bits]
- K_d (derivative gain) [K bits]
- K_i (integration gain) [K bits]
- dt (time difference) [K bits]
- clk [1 bit]
- reset [1 bit]

### Output
u_t [k bits]