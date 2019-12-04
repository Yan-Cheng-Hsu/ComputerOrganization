`timescale 1ns / 1ps

module Mux_32Bits(Mux_32bits_out, Mux_32bits_in0, Mux_32bits_in1, Sel) ; 

	output [31:0]Mux_32bits_out ;
	reg [31:0]Mux_32bits_out ;
	input [31:0]Mux_32bits_in0, Mux_32bits_in1 ;
	input Sel;

	always @(*)begin
		if(Sel==1'b0)
			Mux_32bits_out=Mux_32bits_in0;
		else
			Mux_32bits_out=Mux_32bits_in1;
	end
endmodule
