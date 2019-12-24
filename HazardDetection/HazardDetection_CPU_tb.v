module HazardDetection_CPU_tb;

	// Inputs
	reg CLK;
	reg RST;

	// Outputs
	wire [31:0] PC_OUT;

	// Instantiate the Unit Under Test (UUT)
    HazardDetection_CPU HD_CPU_1 (
		.IF_PC_OUT(PC_OUT), 
		.CLK(CLK), 
		.RST(RST)
	);

	initial begin
		CLK = 1'b0 ;
		forever #2 CLK = ~CLK ;
	end 

	initial begin
		// Initialize Inputs
		RST = 1'b0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RST = 1'b1;
		#15 RST = 1'b0 ;
		
	end
      
endmodule
