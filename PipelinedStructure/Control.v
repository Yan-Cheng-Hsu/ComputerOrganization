`timescale 1ns / 1ps

module Control ( RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, OP_Code ) ;

	output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite ; 
	output reg [1:0]ALUOp ;
	input [5:0]OP_Code ;

	always @(OP_Code) begin
		if(OP_Code==6'b000000) begin  // R-Format
			RegDst = 1'b1 ;
			Jump = 1'b0 ;
			Branch = 1'b0 ;
			MemRead = 1'b0 ;
			MemtoReg = 1'b1 ;
			ALUOp = 2'b10 ;
			MemWrite = 1'b0 ;
			ALUSrc = 1'b0 ;
			RegWrite = 1'b1 ;
		end
		else if(OP_Code==6'b100011) begin  // lw
			RegDst = 1'b0 ;
			Jump = 1'b0 ;
			Branch = 1'b0 ;
			MemRead = 1'b1 ;
			MemtoReg = 1'b0 ;
			ALUOp = 2'b00 ;
			MemWrite = 1'b0 ;
			ALUSrc = 1'b1 ;
			RegWrite = 1'b1 ;
		end
		else if(OP_Code==6'b101011) begin  // sw
			RegDst = 1'b0 ;		//do not care
			Jump = 1'b0 ;
			Branch = 1'b0 ;
			MemRead = 1'b0 ;
			MemtoReg = 1'b0 ;	//do not care
			ALUOp = 2'b00 ;
			MemWrite = 1'b1 ;
			ALUSrc = 1'b1 ;
			RegWrite = 1'b0 ;
		end
		else if(OP_Code==6'b001000) begin  // addi
			RegDst = 1'b0 ;
			Jump = 1'b0 ;
			Branch = 1'b0 ;
			MemRead = 1'b0 ;
			MemtoReg = 1'b1 ;
			ALUOp = 2'b00 ;
			MemWrite = 1'b0 ;
			ALUSrc = 1'b1 ;
			RegWrite = 1'b1 ;
		end 
		else if(OP_Code==6'b000100) begin  // beq
			RegDst = 1'b0 ;		//do not care
			Jump = 1'b0 ;
			Branch = 1'b1 ;
			MemRead = 1'b0 ;
			MemtoReg = 1'b0 ;	//do not care
			ALUOp = 2'b01 ;
			MemWrite = 1'b0 ;
			ALUSrc = 1'b0 ;
			RegWrite = 1'b0 ;
		end
		else if(OP_Code==6'b000010) begin  // jump
			RegDst = 1'b0 ;		//do not care
			Jump = 1'b1 ;	
			Branch = 1'b0 ;		//do not care
			MemRead = 1'b0 ;	//do not care
			MemtoReg = 1'b0 ;	//do not care
			ALUOp = 2'b00 ;		//do not care
			MemWrite = 1'b0 ;	//do not care
			ALUSrc = 1'b0 ;		//do not care
			RegWrite = 1'b0 ;	//do not care
		end
		else begin  // Error input
			RegDst = 1'b0 ;		//do not care
			Jump = 1'b0 ;		//do not care
			Branch = 1'b0 ;		//do not care
			MemRead = 1'b0 ;	//do not care
			MemtoReg = 1'b0 ;	//do not care
			ALUOp = 2'b00 ;		//do not care
			MemWrite = 1'b0 ;	//do not care
			ALUSrc = 1'b0 ;		//do not care
			RegWrite = 1'b0 ;	//do not care
		end
	end

endmodule