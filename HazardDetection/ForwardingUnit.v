module ForwardingUnit(ForwardA, ForwordB, Ex_Rs , Ex_Rt, Mem_Rd, Wb_Rd, Mem_RegWrite, Wb_RegWrite);

output [1:0]ForwardA, ForwordB;
reg [1:0]ForwardA, ForwordB;
input [4:0]Ex_Rs, Ex_Rt, Mem_Rd, Wb_Rd;
input Mem_RegWrite, Wb_RegWrite;

always@(*)
begin

    //Rs
    //ForwardA
    //EX HAZARD
    if( (Mem_RegWrite==1'b1) && (Mem_Rd!=5'd0) && (Mem_Rd==Ex_Rs) )begin
        ForwardA = 2'b10;
    end
    //MEM HAZARD
    else if( (Wb_RegWrite==1'b1) && (Wb_Rd!=5'd0) && (Wb_Rd==Ex_Rs) && ( ~( (Mem_RegWrite==1'b1) && (Mem_Rd!=5'd0) && (Mem_Rd==Ex_Rs) ) ) )begin
        ForwardA = 2'b01;
    end
    //NO HAZARD
    else begin
        ForwardA = 2'b00;
    end

    //Rt
    //ForwardB
    if( (Mem_RegWrite==1'b1) && (Mem_Rd!=5'd0) && (Mem_Rd==Ex_Rt) )begin
        ForwardB = 2'b10;
    end
    //MEM HAZARD
    else if( (Wb_RegWrite==1'b1) && (Wb_Rd!=5'd0) && (Wb_Rd==Ex_Rt) && ( ~( (Mem_RegWrite==1'b1) && (Mem_Rd!=5'd0) && (Mem_Rd==Ex_Rt) ) ) )begin
        ForwardB = 2'b01;
    end
    //NO HAZARD
    else begin
        ForwardB = 2'b00;
    end

end


endmodule