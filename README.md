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
    
	modport primary(output start, stop, data, valid, input ready );
	modport secondary(input start, stop, data, valid, output ready );
endinterface
```

Variation without Start-Stop

``` verilog
interface pipe #(WIDTH=8);
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport primary(output data, valid, input ready );
	modport secondary(input data, valid, output ready );
endinterface
```

Attempt a build for Radiant

```
fusesoc run --target=crosslink_nx_evn SpokeFPGA:pipe:pipe
```

The test files are included, so it's easy to do sims from radiant

Q: how to run-gui?

Do a verilator run

```
fusesoc run --target=verilator SpokeFPGA:pipe:pipe
```

Attempt an Icarus run

```
fusesoc run --target=sim --tool=icarus SpokeFPGA:pipe:pipe
```

Note that icarus doesn't like Interfaces, so it doesn't even get started