# PIPE

Pipe Utilities

Variation with Start-Stop

``` verilog
interface pipe_s #(WIDTH=8);
	logic start;
	logic stop;
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport controller (output start, stop, data, valid, input ready );
	modport agent (input start, stop, data, valid, output ready );
endinterface
```

Variation without Start-Stop

``` verilog
interface pipe #(WIDTH=8);
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport controller (output data, valid, input ready );
	modport agent (input data, valid, output ready );
endinterface
```

