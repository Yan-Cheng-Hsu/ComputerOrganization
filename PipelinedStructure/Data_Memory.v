`timescale 1ns / 1ps

module Data_Memory (
  output [31:0] Read_data,      // Output of Memory Address Contents
  input [31:0] Address,          // Memory Address
  input [31:0] Write_data,    // Memory Address Contents
  input MemWrite, MemRead,
  input RST, 
  input CLK                 // All synchronous elements, including memories, should have a clock signal
);

  reg [31:0] memory[0:63];  // 64 words of 32-bit memory
  //reg [31:0] Read_data;
  //assign Read_data = memory[Address] ;
  
  wire [31:0]Real_Addr;
  assign Real_Addr = Address >> 2;
  assign Read_data = (MemWrite == 1'b0 && MemRead == 1'b1) ? memory[Real_Addr] : 32'd0;
	
  integer i;
  // Using @(addr) will lead to unexpected behavior as memories are synchronous elements like registers
  always @(posedge CLK or posedge RST) begin
    if ( RST == 1 ) begin 
     	for (i = 0; i < 64; i = i + 1) begin
    		memory[i] <= 32'b0 ;
     	end
    end

    else begin
    	if ( MemWrite == 1'b1 && MemRead == 1'b0 ) 
      		memory[Real_Addr] <= Write_data ;
		else
      		memory[Real_Addr] <= memory[Real_Addr] ;
    end
    
  end

endmodule


