
module Mux_32Bits_3input(Mux_out, Mux_in0, Mux_in1, Mux_in2, Mux_Sel) ; 

	output [31:0]Mux_out ;
    reg [31:0]Mux_out ;
	input [31:0]Mux_in0, Mux_in1 ,Mux_in2;
	input [1:0]Mux_Sel;

	always@(*)
	begin
		if (Mux_Sel == 2'b00)begin
			Mux_out = Mux_in0;
        end
		else if (Mux_Sel == 2'b01)begin
			Mux_out = Mux_in1;
        end
		else if (Mux_Sel == 2'b10)begin
			Mux_out = Mux_in2;
        end
		else begin   // Error
			Mux_out = Mux_in0;
        end
	end
	
endmodule
