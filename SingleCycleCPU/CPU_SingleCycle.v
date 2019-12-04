`timescale 1ns / 1ps

module CPU_SingleCycle (PC_OUT, CLK, RST) ;
	output [31:0]PC_OUT ;
	input CLK, RST ;
	wire [31:0]PC_OUT, PC_IN, INSTRUCTION, READ_DATA_1, READ_DATA_2,
		SIGN_EXTEND_OUT, ALU_IN1, ALU_RESULT, DATAMEMORY_OUTPUT, WRITE_DATA,
		PC_4, SL32_OUTPUT, PC_BRANCH, BRANCH_RESULT ;  // 32bits
	wire [27:0]SL28_OUTPUT ;
	wire [4:0]WRITE_ADDRESS ; // 5bits
	wire [3:0]ALU_CONTROL ; // 4bits
	wire [1:0]ALUOP ; // 2bits 
	wire REGDST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD, MEMWRITE, BRANCH, JUMP, ZERO, BRANCH_SEL ;  // 1bits


	PC PROGRAM_COUNTER(.PC_out(PC_OUT), .PC_in(PC_IN), .clk(CLK), .rst(RST));

	InstructionMemory IM(.instruction(INSTRUCTION), .pc(PC_OUT), .rst(RST)) ;
	Control CONTROL( .RegDst(REGDST), .ALUSrc(ALUSRC), .MemtoReg(MEMTOREG), .RegWrite(REGWRITE), 
					.MemRead(MEMREAD), .MemWrite(MEMWRITE), .Branch(BRANCH), .Jump(JUMP), .ALUOp(ALUOP), .OP_Code(INSTRUCTION[31:26]) ) ;
	Mux_5Bits MUX_5(.Mux_5bits_out(WRITE_ADDRESS), .Mux_5bits_in0(INSTRUCTION[20:16]), .Mux_5bits_in1(INSTRUCTION[15:11]), .SEL(REGDST)) ; 

	Register_file RF(.Read_data_1(READ_DATA_1), .Read_data_2(READ_DATA_2), .Read_address_1(INSTRUCTION[25:21]), .Read_address_2(INSTRUCTION[20:16]), 
		.Write_address(WRITE_ADDRESS), .Write_data(WRITE_DATA), .RegWrite(REGWRITE), .CLK(CLK),.RST(RST) );   //   1 

	SignExtend  SE(.sign_extend_out(SIGN_EXTEND_OUT) , .sign_extend_in(INSTRUCTION[15:0] ) ) ;

	Mux_32Bits MUX32_1(.Mux_32bits_out(ALU_IN1), .Mux_32bits_in0(READ_DATA_2), .Mux_32bits_in1(SIGN_EXTEND_OUT), .Sel(ALUSRC) ) ;
	ALU_Control ALUCONTROL( .ALU_Control(ALU_CONTROL), .ALU_OP(ALUOP), .Function_Field(INSTRUCTION[5:0]) ) ;  
	ALU ALU_1(.ALU_result(ALU_RESULT), .Zero(ZERO), .ALU_in0(READ_DATA_1), .ALU_in1(ALU_IN1), .ALU_Control(ALU_CONTROL) ) ; 
W
	Data_Memory DM( .Read_data(DATAMEMORY_OUTPUT), .Address(ALU_RESULT), .Write_data(READ_DATA_2), 
					.MemWrite(MEMWRITE), .MemRead(MEMREAD), .RST(RST), .CLK(CLK) );

	Mux_32Bits Mux32_2(.Mux_32bits_out(WRITE_DATA), . Mux_32bits_in0(ALU_RESULT), .Mux_32bits_in1(DATAMEMORY_OUTPUT), .Sel(MEMTOREG) ) ;



	Add_4 ADD_4_1(.add_4_out(PC_4), .add_4_in(PC_OUT) ) ;// add-4
	ShiftLeft_2 SL32_1( .shift_left_2_out(SL32_OUTPUT), .shift_left_2_in(SIGN_EXTEND_OUT) ) ;
	JAdd JADD_1(.jadd_out(PC_BRANCH), .jadd_in1(PC_4), .jadd_in2(SL32_OUTPUT) ) ;

	and AND1(BRANCH_SEL, BRANCH, ZERO) ;
	Mux_32Bits MUX32_3(.Mux_32bits_out(BRANCH_RESULT), .Mux_32bits_in0(PC_4), .Mux_32bits_in1(PC_BRANCH), .Sel(BRANCH_SEL) ) ;


	ShiftLeft_26to28 SL28_1( .shift_left_26to28_out(SL28_OUTPUT), .shift_left_26to28_in(INSTRUCTION[25:0] ) ) ;
	Mux_32Bits MUX32_4(.Mux_32bits_out(PC_IN), .Mux_32bits_in0(BRANCH_RESULT), .Mux_32bits_in1( {PC_4[31:28], SL28_OUTPUT} ), .Sel(JUMP) ) ;

endmodule 
