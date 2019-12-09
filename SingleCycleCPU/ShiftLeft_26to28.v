`timescale 1ns / 1ps

module ShiftLeft_26to28(shift_left_26to28_out, shift_left_26to28_in);

	output [27:0]shift_left_26to28_out;
	input [25:0]shift_left_26to28_in; 

	assign shift_left_26to28_out = { shift_left_26to28_in, 2'b00 };

endmodule