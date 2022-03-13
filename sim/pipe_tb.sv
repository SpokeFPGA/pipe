

 `define Clock100MHz \
 logic  clock_100; \
 integer clock_count_sim_100; \
 initial begin \
      clock_count_sim_100 = 0; \
      forever begin \
        clock_100 = 1; \
        clock_count_sim_100 = clock_count_sim_100 + 1; \
        #10 \
        clock_100 = 0; \
        #10 \
        ; \
      end \
 end
 
 
`define Realtime \
 integer realtime_ns; \
 initial begin \
     realtime_ns = 0; \
     forever begin \
         realtime_ns = realtime_ns + 1; \
         #1; \
     end \
 end
 
 
`define AssertSetup integer AssertErrorCount = 0; integer AssertTestCount = 0;
`define AssertClear AssertErrorCount = 0; AssertTestCount = 0;
`define Assert(condition, message) begin if(!(condition)) begin AssertErrorCount = AssertErrorCount + 1; $display(`"    Assertion 'condition' Failed. %0s (%s:%0d)`", message, `__FILE__, `__LINE__ );  end AssertTestCount = AssertTestCount + 1; end
`define AssertEqual(val1, val2, message) begin if(val1!=val2) begin AssertErrorCount = AssertErrorCount + 1; $display(`"    Assertion 'val1' %0x == 'val2' %0x Failed. %0s (%s:%0d)`", val1, val2, message, `__FILE__, `__LINE__ );  end AssertTestCount = AssertTestCount + 1; end
`define AssertEqualEpsilon(val1, val2, eps, message) begin \
        if(val1>val2) begin \
            if ( ( val1-val2) > eps ) begin AssertErrorCount = AssertErrorCount + 1; $display(`"    Assertion 'val1' %0x =~= 'val2' %0x Failed. %0s (%s:%0d)`", val1, val2, message, `__FILE__, `__LINE__ );  end \
        end else begin  \
            if ( ( val2-val1) > eps ) begin AssertErrorCount = AssertErrorCount + 1; $display(`"    Assertion 'val1' %0x =~= 'val2' %0x Failed. %0s (%s:%0d)`", val1, val2, message, `__FILE__, `__LINE__ );  end \
        end \
        AssertTestCount = AssertTestCount + 1; \
    end

`define AssertSummary $display( "    Tests %0d/%0d", AssertTestCount - AssertErrorCount, AssertTestCount );

`define OutputDebug   0
`define OutputInfo    1
`define OutputWarning 2
`define OutputError   3
`define OutputNone    4

`define Debug( m ) if ( Output <= `OutputDebug ) $display( m )
`define Info( m ) if ( Output <= `OutputInfo ) $display( m )
`define Warn( m ) if ( Output <= `OutputWarning ) $display( m )
`define Error( m ) if ( Output <= `OutputError ) $display( m )

`define DebugDo if ( Output <= `OutputDebug )
`define InfoDo if ( Output <= `OutputInfo )
`define WarnDo if ( Output <= `OutputWarning )
`define ErrorDo if ( Output <= `OutputError )

module module_down( input logic clock, interface h );
	logic [h.WIDTH-1:0] in_module;
endmodule

module module_up( input logic clock, interface h );
	
endmodule

module dw_interfaces_test( input logic clock );

	parameter Output=`OutputDebug;
	// parameter Output=`OutputInfo;
	// parameter Output=`OutputError;
	
	handshake_if handshake();
	
	module_down down( clock, handshake.down ); 
	module_up up( clock, handshake.down ); 

	task test(
		inout integer AssertErrorCount, inout integer AssertTestCount			
	);
	
		begin
			
			`InfoDo $display( "Test Start" );

			#5

			`InfoDo $display( "Test End" );

			`AssertEqual( 1, 1, "True" );

		end
    endtask

endmodule

 
module pipe_tb();

   parameter clk_freq_hz = 50_000;

    parameter Output=`OutputDebug;
    // parameter Output=`OutputInfo;
    // parameter Output=`OutputError;

    reg  reset;

    initial begin
      $dumpfile("dw_interfaces_tb.vcd");
      $dumpvars( 0, dw_interfaces_tb );
    end

    // create the realtime_ns counter
    `Realtime

    // create the 10MHz clock
    `Clock100MHz

    `AssertSetup

	dw_interfaces_test dwit( clock_100 );

	initial begin

		dwit.test( AssertErrorCount, AssertTestCount );
	
		`AssertSummary

		$finish;
	end
	 
endmodule
