module topmodule(
    input clk,rst,start,
    input [3:0] Q,M,
    output [7:0] result,
    output done_top
);

wire load,add_en,sub_en,shift_en,q0,qn1,done;
wire [3:0] M_in,Q_in;

assign done_top = done;

controller ctrl(
    .clk(clk), .start(start), .rst(rst),
    .q(Q), .m(M), .q0(q0), .qn1(qn1),
    .add_en(add_en), .shift_en(shift_en), .sub_en(sub_en), .load(load),
    .Q_in(Q_in), .M_in(M_in), .done(done) 
);

datapath dp(
    .clk(clk), .rst(rst), .load(load),
    .add_en(add_en), .sub_en(sub_en), .shift_en(shift_en),
    .M_in(M_in), .Q_in(Q_in), .res(result), .q0(q0), .qn1(qn1)
);


endmodule