
module pipe_test( input logic clock, input logic [p.WIDTH-1:0] in, output logic [p.WIDTH-1:0] out );
	
	pipe p();

	pipe_primary down( clock, in, p.primary ); 
	pipe_secondary up( clock, p.secondary, out ); 

endmodule
