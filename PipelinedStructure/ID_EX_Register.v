module ID_EX_Register(RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out,ALUSrc_out, RegDst_out, ALUop_out, 
	PC_4_out, Read_Data_1_out, Read_Data_2_out, SignExtend_out, Rt_out, Rd_out,
	RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in, ALUSrc_in, RegDst_in, ALUop_in, 
	PC_4_in, Read_Data_1_in, Read_Data_2_in, SignExtend_in, Rt_in, Rd_in, clk, rst);



output RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, RegDst_out;
reg RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, RegDst_out;
output [1:0]ALUop_out;
reg [1:0]ALUop_out;
output [31:0]PC_4_out, Read_Data_1_out, Read_Data_2_out, SignExtend_out;
reg [31:0]PC_4_out, Read_Data_1_out, Read_Data_2_out, SignExtend_out;
output [4:0]Rt_out, Rd_out;
reg [4:0]Rt_out, Rd_out;



input RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in, ALUSrc_in, RegDst_in;
input [1:0]ALUop_in;
input [31:0]PC_4_in, Read_Data_1_in, Read_Data_2_in, SignExtend_in;
input [4:0]Rt_in, Rd_in;
input clk, rst;



always@(posedge clk or posedge rst)
	if(rst)begin        
        RegWrite_out<=1'b0;
        MemtoReg_out<=1'b0;
        Branch_out<=1'b0;
        MemRead_out<=1'b0;
        MemWrite_out<=1'b0;
        RegDst_out<=1'b0;
        ALUSrc_out<=1'b0;
        ALUop_out<=2'd0;
        PC_4_out<=32'd0;
        Read_Data_1_out<=32'd0;
        Read_Data_2_out<=32'd0;
        SignExtend_out<=32'd0;
        Rd_out<=5'd0;
        Rt_out<=5'd0;
	end
	else begin
        RegWrite_out<=RegWrite_in;
        MemtoReg_out<=MemtoReg_in;
        Branch_out<=Branch_in;
        MemRead_out<=MemRead_in;
        MemWrite_out<=MemWrite_in;
        RegDst_out<=RegDst_in;
        ALUSrc_out<=ALUSrc_in;
        ALUop_out<=ALUop_in;
        PC_4_out<=PC_4_in;
        Read_Data_1_out<=Read_Data_1_in;
        Read_Data_2_out<=Read_Data_2_in;
        SignExtend_out<=SignExtend_in;
        Rd_out<=Rd_in;
        Rt_out<=Rt_in;
	end


endmodule