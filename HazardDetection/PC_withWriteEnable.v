
module PC_withWriteEnable(PC_out, PC_in, PCWrite, clk, rst);

output [31:0]PC_out;
reg [31:0]PC_out;
input PCWrite, clk, rst;

always@(posedge clk or posedge rst)
begin
    if(rst)begin
        PC_out<=32'd0; 
    end
    else begin
        if(PCWrite==1'b1)begin
            PC_out<=PC_in;
        end
        else begin
            PC_out<=PC_out;
        end
    end
end


endmodule