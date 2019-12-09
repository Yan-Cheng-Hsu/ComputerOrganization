`timescale 1ns / 1ps

module	Mux_5bits(Mux_5bits_out, Mux_5bits_in0, Mux_5bits_in1, RegDst);

	output [4:0]Mux_5bits_out;
	reg [4:0]Mux_5bits_out;
	input [4:0]Mux_5bits_in0;
	input [4:0]Mux_5bits_in1;
	input RegDst;

	always@(*)
	begin
		if(RegDst == 1'b0 )begin
			Mux_5bits_out = Mux_5bits_in0;
		end
		else begin
			Mux_5bits_out = Mux_5bits_in1;
		end
	end

endmodule