`include "sim.svh"


module pipe_tb();

   parameter clk_freq_hz = 50_000;

    parameter Output=`OutputDebug;
    // parameter Output=`OutputInfo;
    // parameter Output=`OutputError;

    reg  reset;

    initial begin
      $dumpfile("pipe_tb.vcd");
      $dumpvars( 0, pipe_tb );
    end

    // create the realtime_ns counter
    `Realtime

    // create the 10MHz clock
    `Clock100MHz

    `AssertSetup

	logic [7:0] in;
	logic [7:0] out;

	pipe_test pt( clock_100,  );

	task test_pt();

		`Assert( 1, "Yup" );

		in = 100;

		#1 

		in = 200;
	endtask

	initial begin

		test_pt(  );
	
		`AssertSummary


		$finish;
	end
	 
endmodule

