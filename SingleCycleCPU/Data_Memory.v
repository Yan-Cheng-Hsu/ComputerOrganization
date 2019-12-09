`timescale 1ns / 1ps

module Data_Memory (
  output reg [31:0] Read_data,      // Output of Memory Address Contents
  input [31:0] Address,          // Memory Address
  input [31:0] Write_data,    // Memory Address Contents
  input MemWrite, MemRead,
  input RST, 
  input CLK                 // All synchronous elements, including memories, should have a clock signal
);

  reg [31:0] memory[0:63];  // 64 words of 32-bit memory
  //reg [31:0] Read_data;
  //assign Read_data = memory[Address] ;


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
      		memory[Address] <= Write_data ;
      	else if(MemWrite == 1'b0 && MemRead == 1'b1)
			Read_data <= memory[Address] ;
		else
      		memory[Address] <= memory[Address] ;
    end
    
  end

endmodule


