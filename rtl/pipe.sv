
interface handshake_if #(WIDTH=8,STARTSTOP=1);
	logic start;
	logic stop;
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport down (output start, stop, data, valid, input ready );
	modport up (input start, stop, data, valid, output ready );

endinterface

