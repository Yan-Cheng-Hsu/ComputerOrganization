`timescale 1ns / 1ps

module JAdd(jadd_out, jadd_in1, jadd_in2) ;

	output [31:0]jadd_out ;
	input [31:0]jadd_in1, jadd_in2 ; 

	assign jadd_out = jadd_in1 + jadd_in2;

endmodule