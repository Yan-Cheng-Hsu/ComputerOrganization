`timescale 1ns / 1ps

module PC(PC_out, PC_in, clk, rst);
	output [31:0]PC_out;
	reg [31:0]PC_out;
	input [31:0]PC_in;
	input clk, rst;

	always@(posedge clk or posedge rst)
	begin
		if(rst == 1'b1)begin
			PC_out <= 32'd0;
		end
		else begin
			PC_out <= PC_in;
		end
	end

endmodule