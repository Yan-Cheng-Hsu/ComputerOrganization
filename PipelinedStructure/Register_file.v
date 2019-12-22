module Register_file(
Read_data_1, Read_data_2,
Read_address_1, Read_address_2, Write_address, Write_data,
RegWrite, CLK, RST
);

output [31:0] Read_data_1, Read_data_2;
input [31:0] Write_data;
input [4:0] Read_address_1, Read_address_2, Write_address;
input RegWrite, CLK, RST;

reg [31:0] Registers[31:0];

integer i;

assign Read_data_1 =  Registers[Read_address_1];
assign Read_data_2 =  Registers[Read_address_2];

always@(posedge CLK or posedge RST) begin
	if(RST)begin
		for(i=0; i<32; i=i+1)
			Registers[i] <= 32'b0;
	end
	else begin
		if ( RegWrite==1'b1 && Write_address!=0 )
			Registers[Write_address] <= Write_data;
		else
			Registers[Write_address] <= Registers[Write_address];
	end

end

endmodule
