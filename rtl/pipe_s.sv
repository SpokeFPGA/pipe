
interface pipe_s #(WIDTH=8);
	logic start;
	logic stop;
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport primary(output start, stop, data, valid, input ready );
	modport secondary(input start, stop, data, valid, output ready );
endinterface

