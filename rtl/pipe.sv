
interface pipe #(WIDTH=8);
    logic [WIDTH-1:0] data;
	logic ready;
	logic valid;
    
	modport primary(output data, valid, input ready );
	modport secondary(input data, valid, output ready );

endinterface

