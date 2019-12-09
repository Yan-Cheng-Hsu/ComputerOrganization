`timescale 1ns / 1ps

module Add_4(add_4_out, add_4_in);

	output [31:0]add_4_out;
	input [31:0]add_4_in; 

	assign add_4_out = add_4_in + 32'd4;

endmodule