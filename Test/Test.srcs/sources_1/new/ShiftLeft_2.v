`timescale 1ns / 1ps

module ShiftLeft_2(shift_left_2_out, shift_left_2_in);

	output [31:0]shift_left_2_out;
	input [31:0]shift_left_2_in; 

	assign shift_left_2_out = shift_left_2_in << 2;

endmodule