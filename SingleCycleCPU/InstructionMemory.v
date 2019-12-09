`timescale 1ns / 1ps

module InstructionMemory(instruction, pc, rst) ;
	output [31:0]instruction;
	input [31:0]pc;
	input rst;

	reg [31:0]instruction_memory[63:0];

	wire [31:0]mem_addr;
	assign mem_addr = pc >> 2;
	assign instruction = instruction_memory[mem_addr];



	integer k;
	always @(posedge rst)
	begin	
		instruction_memory[0] <= 32'b001000_00000_10000_0000000000010101;
		instruction_memory[1] <= 32'b001000_00000_10001_0000000000010111;
		instruction_memory[2] <= 32'b101011_10001_10000_0000000000000100;
		instruction_memory[3] <= 32'b000000_10000_10001_10010_00000_100010;
		instruction_memory[4] <= 32'b001000_00000_10001_1111111111111110;
		instruction_memory[5] <= 32'b000100_10001_10010_0000000000000011;
		instruction_memory[6] <= 32'b001000_00000_10001_0000000000010111;
		instruction_memory[7] <= 32'b100011_10001_10000_0000000000000100;
		instruction_memory[8] <= 32'b000010_00000000000000000000001110;
		instruction_memory[9] <= 32'b000000_10001_10010_10100_00000_100100;
		instruction_memory[10] <= 32'b000000_10100_10000_01000_00000_100101;
		instruction_memory[11] <= 32'b000000_10001_10010_10100_00000_101010;
		instruction_memory[12] <= 32'b000000_10100_01000_01001_00000_100000;
		instruction_memory[13] <= 32'b000010_00000000000000000000000110;
		for (k=14; k<64; k=k+1) begin 
			instruction_memory[k] <= 32'b0;
		end	

	end

endmodule