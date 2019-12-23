`timescale 1ns / 1ps

module ALU_Control( ALU_Control, ALU_OP, Function_Field ) ; 

	output reg [3:0]ALU_Control ; 
	input [1:0] ALU_OP ;
	input [5:0] Function_Field ; 

	always @(ALU_OP or Function_Field) begin
		case(ALU_OP)
			2'b00 :       // sw/lw(add)
				ALU_Control = 4'b0010 ;
			2'b01 :  // branch(subtract)
				ALU_Control = 4'b0110 ;
			2'b10 :	begin //R-type
				case(Function_Field) 
					6'b100000 : // add
						ALU_Control = 4'b0010 ; 
					6'b100010 : // subtract
						ALU_Control = 4'b0110 ; 
					6'b100100 : // AND
						ALU_Control = 4'b0000 ; 
					6'b100101 : // OR
						ALU_Control = 4'b0001 ; 
					6'b101010 : // set on less than
						ALU_Control = 4'b0111 ;
					default :	//error
						ALU_Control = 4'b1111 ; 
				endcase
			end
			default : // error
				ALU_Control = 4'b1111 ; 
		endcase
	end
endmodule
