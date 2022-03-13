
module pipe_secondary( input logic clock, pipe h, output logic [h.WIDTH-1:0] out );

	logic [h.WIDTH-1:0] in_module;

    always_ff @( posedge clock ) begin 
		if ( h.valid ) begin
			in_module <= h.data;
	        h.ready <= 1;
		end else begin
			in_module <= 0;
	        h.ready <= 0;
		end
		out <= in_module;
    end

endmodule

