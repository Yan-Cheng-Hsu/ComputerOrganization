module IF_ID_Register (PC_4_out, Instruction_out, PC_4_in, Instruction_in, clk, rst);


output [31:0]PC_4_out;
reg [31:0]PC_4_out;
output [31:0]Instruction_out;
reg [31:0]Instruction_out;
input [31:0]PC_4_in;
input [31:0]Instruction_in;
input clk, rst;



always@(posedge clk or posedge rst)
begin
    if(rst)begin
        Instruction_out<=32'd0;
        PC_4_out<=32'd0;
    end
    else begin
        Instruction_out<=Instruction_in;
        PC_4_out<=PC_4_in;
    end
end



endmodule