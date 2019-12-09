`timescale 1ns / 1ps

module SignExtend(sign_extend_out, sign_extend_in);

	output [31:0]sign_extend_out;
	reg [31:0]sign_extend_out;
	input [15:0]sign_extend_in; 

	always@(*)
	begin
		if(sign_extend_in[15] == 0)begin
			sign_extend_out = {16'b0000000000000000, sign_extend_in};
		end
		else begin
			sign_extend_out = {16'b1111111111111111, sign_extend_in};
		end
	end


endmodule