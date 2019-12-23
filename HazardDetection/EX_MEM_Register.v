module EX_MEM_Register(RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out,
	Add_Result_out, ALU_Result_out, Read_Data_2_out, Write_Addr_out, Zero_out,
	RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in,
	Add_Result_in, ALU_Result_in, Read_Data_2_in, Write_Addr_in, Zero_in, clk, rst);


output RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out;
reg RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out;
output [31:0]Add_Result_out, ALU_Result_out, Read_Data_2_out;
reg [31:0]Add_Result_out, ALU_Result_out, Read_Data_2_out;
output [4:0]Write_Addr_out;
reg [4:0]Write_Addr_out;
output Zero_out;
reg Zero_out;


input RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in;
input [31:0]Add_Result_in, ALU_Result_in, Read_Data_2_in;
input [4:0]Write_Addr_in;
input Zero_in, clk, rst;


always@(posedge clk or posedge rst)
	if(rst)begin
        RegWrite_out<=1'b0;
        MemtoReg_out<=1'b0;
        Branch_out<=1'b0;
        MemRead_out<=1'b0;
        MemWrite_out<=1'b0;

        Add_Result_out<=32'd0;
        ALU_Result_out<=32'd0;
        Read_Data_2_out=32'd0;
        Write_Addr_out<=5'd0;
        Zero_out<=1'b0;
	end
	else begin
        RegWrite_out<=RegWrite_in;
        MemtoReg_out<=MemtoReg_in;
        Branch_out<=Branch_in;
        MemRead_out<=MemRead_in;
        MemWrite_out<=MemWrite_in;
        
        Add_Result_out<=Add_Result_in;
        ALU_Result_out<=ALU_Result_in;
        Read_Data_2_out=Read_Data_2_in;
        Write_Addr_out<=Write_Addr_in;
        Zero_out<=Zero_in;
	end
endmodule