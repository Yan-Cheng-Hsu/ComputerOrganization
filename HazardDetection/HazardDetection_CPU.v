`timescale 1ns / 1ps

module PipelinedStructure (IF_PC_OUT, CLK, RST) ;
    output[31:0]IF_PC_OUT;
    input CLK, RST;
    
    //IF
    wire [31:0]IF_PC_OUT, IF_PC_IN, IF_INSTRUCTION, IF_ADDPC;
    wire IF_PCWRITE;//HAZARD ADDED
	PC ProgramCounter(.PC_out(IF_PC_OUT), .PC_in(IF_PC_IN), .PCWrite(IF_PCWRITE), .clk(CLK), .rst(RST));
	InstructionMemory IM(.instruction(IF_INSTRUCTION), .pc(IF_PC_OUT), .rst(RST)) ; 
    Add_4 Add_4_1(.add_4_out(IF_ADDPC), .add_4_in(IF_PC_OUT));




	//IF-ID REGISTER
    wire [31:0]ID_ADDPC, ID_INSTRUCTION;
    wire IF_ID_WRITE;//HAZARD ADDED
	IF_ID_Register IF_ID_Reg(.PC_4_out(ID_ADDPC), .Instruction_out(ID_INSTRUCTION), .PC_4_in(IF_ADDPC), .Instruction_in(IF_INSTRUCTION), .IF_ID_Write(IF_ID_WRITE), .clk(CLK), .rst(RST));




    //ID
	wire WB_REGWRITE, WB_MEMTOREG;
    wire [31:0]ID_REGISTER_READ_DATA_1, ID_REGISTER_READ_DATA_2, ID_SIGNEXTEND;
    wire ID_REGWRITE, ID_MEMTOREG, ID_BRANCH, ID_MEMREAD, ID_MEMWRITE, ID_ALUSRC, ID_REGDST;
    wire [1:0]ID_ALUOP;
    wire [4:0]ID_REGISTER_ADDRESS_FEEDBACK;
    wire [31:0]ID_WRITE_DATA;
	Register_file RF(.Read_data_1(ID_REGISTER_READ_DATA_1), .Read_data_2(ID_REGISTER_READ_DATA_2), .Read_address_1(ID_INSTRUCTION[25:21]), .Read_address_2(ID_INSTRUCTION[20:16]), 
	.Write_address(ID_REGISTER_ADDRESS_FEEDBACK), .Write_data(ID_WRITE_DATA), .RegWrite(WB_REGWRITE), .CLK(CLK),.RST(RST) );   
	SignExtend  SE(.sign_extend_out(ID_SIGNEXTEND) , .sign_extend_in(ID_INSTRUCTION[15:0]) ) ;

    //ID HAZARD ADDED OR MODIFIED
    wire CONTROL_UNIT_SEL;//HARARD ADDED
    wire CONTORL_UNIT_OUT_REGWRITE, CONTORL_UNIT_OUT_MEMTOREG, CONTORL_UNIT_OUT_BRANCH, CONTORL_UNIT_OUT_MEMREAD;//HAZARD ADDED
    wire CONTORL_UNIT_OUT_MEMWRITE, CONTORL_UNIT_OUT_ALUSRC, CONTORL_UNIT_OUT_REGDST;//HAZARD ADDED
    wire [1:0]CONTORL_UNIT_OUT_ALUOP;//HAZARD ADD

	Control control_unit( .RegDst(CONTORL_UNIT_OUT_REGDST), .ALUSrc(CONTORL_UNIT_OUT_ALUSRC), .MemtoReg(CONTORL_UNIT_OUT_MEMTOREG), .RegWrite(CONTORL_UNIT_OUT_REGWRITE), 
					.MemRead(CONTORL_UNIT_OUT_MEMREAD), .MemWrite(CONTORL_UNIT_OUT_MEMWRITE), .Branch(CONTORL_UNIT_OUT_BRANCH), .ALUOp(CONTORL_UNIT_OUT_ALUOP), .OP_Code(ID_INSTRUCTION[31:26]) ) ;
    MuxforControlSel Mux_Control_Unit( .RegWrite_out(ID_REGWRITE), .MemtoReg_out(ID_MEMTOREG), .Branch_out(ID_BRANCH), .MemRead_out(ID_MEMREAD), 
                                       .MemWrite_out(ID_MEMWRITE), .ALUSrc_out(ID_ALUSRC), .RegDst_out(ID_REGDST), .ALUop_out(ID_ALUOP),
                                       .RegWrite_in(CONTORL_UNIT_OUT_REGWRITE), .MemtoReg_in(CONTORL_UNIT_OUT_MEMTOREG), .Branch_in(CONTORL_UNIT_OUT_BRANCH), .MemRead_in(CONTORL_UNIT_OUT_MEMREAD), 
                                       .MemWrite_in(CONTORL_UNIT_OUT_MEMWRITE), .ALUSrc_in(CONTORL_UNIT_OUT_ALUSRC), .RegDst_in(CONTORL_UNIT_OUT_REGDST), .ALUop_in(CONTORL_UNIT_OUT_ALUOP), .Sel(CONTROL_UNIT_SEL) );






    //ID-EX REGISTER
    wire EX_REGWRITE, EX_MEMTOREG, EX_BRANCH, EX_MEMREAD, EX_MEMWRITE, EX_ALUSRC, EX_REGDST;
    wire [1:0]EX_ALUOP;
    wire [31:0]EX_ADDPC, EX_REGISTER_READ_DATA_1, EX_REGISTER_READ_DATA_2, EX_SIGNEXTEND_OUT;
    wire [4:0]EX_RT, EX_RD;
    wire [4:0]EX_RS;//HAZARD ADDED
	ID_EX_Register ID_EX_Reg(.RegWrite_out(EX_REGWRITE), .MemtoReg_out(EX_MEMTOREG), .Branch_out(EX_BRANCH), .MemRead_out(EX_MEMREAD),
	 .MemWrite_out(EX_MEMWRITE), .ALUSrc_out(EX_ALUSRC), .RegDst_out(EX_REGDST), .ALUop_out(EX_ALUOP), 
	 .PC_4_out(EX_ADDPC), .Read_Data_1_out(EX_REGISTER_READ_DATA_1), .Read_Data_2_out(EX_REGISTER_READ_DATA_2), .SignExtend_out(EX_SIGNEXTEND_OUT), .Rt_out(EX_RT), .Rd_out(EX_RD), .Rs_out(EX_RS),//HAZARD ADDED
	.RegWrite_in(ID_REGWRITE), .MemtoReg_in(ID_MEMTOREG), .Branch_in(ID_BRANCH), .MemRead_in(ID_MEMREAD), .MemWrite_in(ID_MEMWRITE), .RegDst_in(ID_REGDST), .ALUSrc_in(ID_ALUSRC), .ALUop_in(ID_ALUOP), 
	.PC_4_in(ID_ADDPC), .Read_Data_1_in(ID_REGISTER_READ_DATA_1), .Read_Data_2_in(ID_REGISTER_READ_DATA_2), .SignExtend_in(ID_SIGNEXTEND), 
	.Rt_in(ID_INSTRUCTION[20:16]), .Rd_in(ID_INSTRUCTION[15:11]), .Rs_in(ID_INSTRUCTION[25:21]), .clk(CLK), .rst(RST));









	//EX DECLARATION
    wire [31:0]EX_ADD_RESULT, EX_SHIFT_LEFT_OUT, EX_MUX_ALU, EX_ALU_RESULT;
    wire [3:0]EX_ALU_CONTROL;
    wire EX_ZERO;
    wire [4:0]EX_WRITE_ADDRESS;

    //EX-MEM REGISTER DECLARATION
    wire MEM_REGWRITE, MEM_MEMTOREG, MEM_BRANCH, MEM_MEMREAD, MEM_MEMWRITE, MEM_ZERO;
    wire [31:0]MEM_ADDPC, MEM_DATAMEMORY_ADDRESS, MEM_DATAMEMORY_WRITE_DATA;
    wire [4:0]MEM_REG_WRITE_ADDRESS;

    //MEM DECLARATION
    wire MEM_PCSRC;
    wire [31:0]MEM_DATAMEMORY_READ_DATA;    

    //MEM-WB REGISTER DECLARATION
    wire [31:0]WB_MUX_0, WB_MUX_1;







    //EX
    JAdd Add_1(.jadd_out(EX_ADD_RESULT), .jadd_in1(EX_ADDPC), .jadd_in2(EX_SHIFT_LEFT_OUT) ) ;
    ShiftLeft_2 SL_1( .shift_left_2_out(EX_SHIFT_LEFT_OUT), .shift_left_2_in(EX_SIGNEXTEND_OUT) ) ;
    Mux_5bits Mux5_1(.Mux_5bits_out(EX_WRITE_ADDRESS), .Mux_5bits_in0(EX_RT), .Mux_5bits_in1(EX_RD), .RegDst(EX_REGDST)) ;
    ALU_Control ALU_control_1( .ALU_Control(EX_ALU_CONTROL), .ALU_OP(EX_ALUOP), .Function_Field(EX_SIGNEXTEND_OUT[5:0]) ) ;

    //HARARD ADDED OR MODIFIED
    wire [31:0]EX_MUX_3INPUTS_1_OUT, EX_MUX_3INPUTS_2_OUT;//HAZARD ADDED
    wire FORWARDA, FORWARDB;//HAZARD ADDED

    Mux_32Bits_3input Mux_3inputs_1( .Mux_out(EX_MUX_3INPUTS_1_OUT), .Mux_in0(EX_REGISTER_READ_DATA_1), 
    .Mux_in1(ID_WRITE_DATA), .Mux_in2(MEM_DATAMEMORY_ADDRESS), .Mux_Sel(FORWARDA) ) ;//HAZARD ADDED

    Mux_32Bits_3input Mux_3inputs_2( .Mux_out(EX_MUX_3INPUTS_2_OUT), .Mux_in0(EX_REGISTER_READ_DATA_2), 
    .Mux_in1(ID_WRITE_DATA), .Mux_in2(MEM_DATAMEMORY_ADDRESS), .Mux_Sel(FORWARDB) ) ;//HAZARD ADDED

    //HAZARD ADDED
    ALU ALU_1(.ALU_result(EX_ALU_RESULT), .Zero(EX_ZERO), .ALU_in0(EX_MUX_3INPUTS_1_OUT), .ALU_in1(EX_MUX_ALU), .ALU_Control(EX_ALU_CONTROL) ) ; 
    Mux_32Bits Mux32_1(.Mux_32bits_out(EX_MUX_ALU), .Mux_32bits_in0(EX_MUX_3INPUTS_2_OUT), .Mux_32bits_in1(EX_SIGNEXTEND_OUT), .Sel(EX_ALUSRC) ) ;
     
	 


	//EX-MEM REGISTER 
	EX_MEM_Register EX_MEM_Reg(.RegWrite_out(MEM_REGWRITE), .MemtoReg_out(MEM_MEMTOREG), .Branch_out(MEM_BRANCH), .MemRead_out(MEM_MEMREAD), . MemWrite_out(MEM_MEMWRITE),
	.Add_Result_out(MEM_ADDPC), .ALU_Result_out(MEM_DATAMEMORY_ADDRESS), .Read_Data_2_out(MEM_DATAMEMORY_WRITE_DATA), .Write_Addr_out(MEM_REG_WRITE_ADDRESS), .Zero_out(MEM_ZERO),
	.clk(CLK), .rst(RST), .RegWrite_in(EX_REGWRITE), .MemtoReg_in(EX_MEMTOREG), .Branch_in(EX_BRANCH), .MemRead_in(EX_MEMREAD), .MemWrite_in(EX_MEMWRITE),
	.Add_Result_in(EX_ADD_RESULT), .ALU_Result_in(EX_ALU_RESULT), .Read_Data_2_in(EX_REGISTER_READ_DATA_2), .Write_Addr_in(EX_WRITE_ADDRESS), .Zero_in(EX_ZERO));
    

    //MEM
    and and_1(MEM_PCSRC, MEM_BRANCH, MEM_ZERO) ;
	Data_Memory DM( .Read_data(MEM_DATAMEMORY_READ_DATA), .Address(MEM_DATAMEMORY_ADDRESS), .Write_data(MEM_DATAMEMORY_WRITE_DATA), 
					.MemWrite(MEM_MEMWRITE), .MemRead(MEM_MEMREAD), .RST(RST), .CLK(CLK) );
	
    //MEM-WB REGISTER
    //wire WB_REGWRITE, WB_MEMTOREG;

	MEM_WB_Register MEM_WB_Reg(.RegWrite_out(WB_REGWRITE), .MemtoReg_out(WB_MEMTOREG), .Read_Data_out(WB_MUX_0), .ALU_Result_out(WB_MUX_1), .Write_Addr_out(ID_REGISTER_ADDRESS_FEEDBACK), 
	.RegWrite_in(MEM_REGWRITE), .MemtoReg_in(MEM_MEMTOREG), .Read_Data_in(MEM_DATAMEMORY_READ_DATA), .ALU_Result_in(MEM_DATAMEMORY_ADDRESS), .Write_Addr_in(MEM_REG_WRITE_ADDRESS), .clk(CLK), .rst(RST));

	//WB 
    Mux_32Bits Mux32_2(.Mux_32bits_out(ID_WRITE_DATA), .Mux_32bits_in0(WB_MUX_0), .Mux_32bits_in1(WB_MUX_1), .Sel(WB_MEMTOREG) ) ; 
	Mux_32Bits Mux32_3(.Mux_32bits_out(IF_PC_IN), .Mux_32bits_in0(IF_ADDPC), .Mux_32bits_in1(MEM_ADDPC), .Sel(MEM_PCSRC) ) ;

    //HAZARD DETECTION
    //FORWARDING UNIT
    ForwardingUnit FW_1( .ForwardA(FORWARDA), .ForwordB(FORWARDB), .Ex_Rs(EX_RS), .Ex_Rt(EX_RT), .Mem_Rd(MEM_REG_WRITE_ADDRESS), 
                        .Wb_Rd(ID_REGISTER_ADDRESS_FEEDBACK), .Mem_RegWrite(MEM_REGWRITE), .Wb_RegWrite(WB_REGWRITE) );
    //HAZARD DETECTION UNIT
    HazardDetectionUnit HD_1(.PCWrite(IF_PCWRITE), .IF_ID_Write(IF_ID_WRITE), .Control_Unit_Sel(CONTROL_UNIT_SEL), 
    .Id_Rs(ID_INSTRUCTION[25:21]), .Id_Rt(ID_INSTRUCTION[20:16]), .Ex_Rt(EX_RT), Ex_MemRead(EX_MEMREAD) );

endmodule 