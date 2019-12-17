`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 19:58:39
// Design Name: 
// Module Name: CPU_SingleCycle_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_SingleCycle_tb;
wire [31:0]PC_OUT;
reg CLK, RST;
CPU_SingleCycle CPU( .PC_OUT(PC_OUT), .CLK(CLK), .RST(RST) );

initial 
begin 
    CLK = 1'b0 ;
	forever #10 CLK = ~CLK ;
end 

initial 
begin
RST = 1'b0;
#20
RST = 1'b1;
#150 RST = 1'b0;


end


endmodule
