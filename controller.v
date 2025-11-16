module controller(
    input clk,start,rst,
    input [3:0] q,m,
    input q0, qn1,
    output reg add_en,shift_en,sub_en,load,
    output reg [3:0] Q_in,M_in,
    output reg done
);

localparam [2:0] IDLE = 3'b000,
LOAD = 3'b001,
CHECK = 3'b010,
ADD = 3'b011,
SUB = 3'b100,
SHIFT = 3'b101,
DONE = 3'b110;

reg [2:0] curr_state,next_state;
reg [2:0] count;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        curr_state<=IDLE;
        count<=3'd0;
    end
    else begin
        curr_state<=next_state;
        if(curr_state == SHIFT)count<=count+1;
        else if(curr_state == LOAD)count<=3'd0;
    end
end

always@(*)begin
    next_state = curr_state;
    case(curr_state)
    IDLE : begin
        if(start)next_state = LOAD;
    end
    LOAD : next_state = CHECK;
    CHECK : begin
        if(count == 3'd4)begin
            next_state=DONE;
        end
        else begin
            case({q0,qn1})
            2'b00 : next_state = SHIFT;
            2'b11 : next_state = SHIFT;
            2'b10 : next_state = SUB;
            2'b01 : next_state = ADD;
            endcase
        end
    end
    ADD : next_state = SHIFT;
    SUB : next_state = SHIFT;
    SHIFT : next_state = CHECK;
    DONE : next_state = IDLE;
    default : next_state = IDLE;
    endcase
end

always@(*)begin
    load=0;
    add_en=0;
    sub_en=0;
    shift_en=0;
    done=0;
    Q_in=4'b0;
    M_in=4'b0;

    case(curr_state)
    IDLE : load = 0;
    LOAD : begin
        load = 1;
        Q_in=q;
        M_in=m;
    end
    ADD : add_en = 1;
    SUB : sub_en = 1;
    SHIFT : shift_en = 1;
    DONE : done=1;
    default : load =0;
    endcase
end
endmodule