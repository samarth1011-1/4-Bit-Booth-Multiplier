module datapath(
    input clk,rst,load,add_en,sub_en,shift_en,
    input [3:0] M_in,Q_in,
    output reg [7:0] res,
    output q0,qn1
);

reg [3:0] acc,Q,M;
reg Qn1;

assign q0=Q[0];
assign qn1=Qn1;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        res<=8'b0;
        Qn1<=0;
        acc<=4'b0;
        Q<=4'b0;
        M<=4'b0;
    end
    else if(load)begin
        M<=M_in;
        Q<=Q_in;
        acc<=0;
        Qn1<=0;
    end
    else if(shift_en)begin
        {acc,Q,Qn1} <= {acc[3],acc,Q};
    end
    else if(add_en)begin
        acc <= acc+M;
    end
    else if(sub_en)begin
        acc <= acc-M;
    end
    res<={acc,Q};
end


endmodule