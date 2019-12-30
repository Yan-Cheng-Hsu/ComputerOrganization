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
	for (k=0); k<64; k=k+1) begin 
		instruction_memory[k] <= 32'b0;
	end	

	end

endmodule