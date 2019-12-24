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
		for (k=11; k<64; k=k+1) begin  // here Ou changes k=0 to k=16
			instruction_memory[k] <= 32'b0;
		end
			instruction_memory[0] <= 32'b001000_00000_01001_0000000000000110;
			instruction_memory[1] <= 32'b001000_00000_01000_0000000000000001;
			instruction_memory[2] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[3] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[4] <= 32'b101011_01000_01000_0000000000001100;
			instruction_memory[5] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[6] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[7] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[8] <= 32'b100011_01001_01000_0000000000000100;
			instruction_memory[9] <= 32'b000000_01000_01000_01000_00000_100000;
			instruction_memory[10] <= 32'b000000_01000_01000_01000_00000_100010;
	end

endmodule