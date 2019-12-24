

module HazardDetectionUnit(PCWrite, IF_ID_Write, Control_Unit_Sel, Id_Rs, Id_Rt, Ex_Rt, Ex_MemRead);

output PCWrite, IF_ID_Write, Control_Unit_Sel;
reg PCWrite, IF_ID_Write, Control_Unit_Sel;
input [4:0]Id_Rs, Id_Rt, Ex_Rt;
input Ex_MemRead;

always@(*)
begin
    //lw Hazard occurs
    if( (Ex_MemRead==1'b1) && ( (Ex_Rt==Id_Rs) || (Ex_Rt==Id_Rt) ) )begin
        PCWrite = 1'b0;
        IF_ID_Write = 1'b0;
        Control_Unit_Sel = 1'b0;
    end
    //No Hazard
    else begin
        PCWrite = 1'b1;
        IF_ID_Write = 1'b1;
        Control_Unit_Sel = 1'b1;
    end
end

endmodule