module MEM_WB_Register(RegWrite_out, MemtoReg_out, 
    Read_Data_out, ALU_Result_out, Write_Addr_out,  
	clk, rst, RegWrite_in, MemtoReg_in,
    Read_Data_in, ALU_Result_in, Write_Addr_in);

output RegWrite_out, MemtoReg_out;
reg RegWrite_out, MemtoReg_out;
output [31:0]Read_Data_out, ALU_Result_out;
reg [31:0]Read_Data_out, ALU_Result_out;
output [4:0]Write_Addr_out;
reg [4:0]Write_Addr_out;

input clk, rst, RegWrite_in, MemtoReg_in;
input [31:0]Read_Data_in, ALU_Result_in;
input [4:0]Write_Addr_in;


always@(posedge clk or posedge rst) begin
	if(rst) begin
        RegWrite_out<=1'b0;
        MemtoReg_out<=1'b0;
        Read_Data_out<=32'd0;
        ALU_Result_out<=32'd0;
        Write_Addr_out<=5'd0;
	end
	else begin
        RegWrite_out<=RegWrite_in;
        MemtoReg_out<=MemtoReg_in;
        Read_Data_out<=Read_Data_in;
        ALU_Result_out<=ALU_Result_in;
        Write_Addr_out<=Write_Addr_in;
	end

end

endmodule