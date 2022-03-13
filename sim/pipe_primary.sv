
module pipe_primary( input logic clock, input logic[h.WIDTH-1:0] in, pipe h );
	
	logic [h.WIDTH-1:0] in_module;

    always_ff @( posedge clock ) begin 
        h.data <= in_module;
        h.valid <= 1;
        if ( h.ready )
            in_module <= in;
        else
            in_module <= in_module + 1;
    end

endmodule

