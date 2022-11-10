module seven_segment (
    input[19:0] num_output, 
    input[3:0] times_output,
    input clk, 
    input rst_n,
    output [7:0] bit_sel,
    output [7:0] Y_0,
    output [7:0] Y_1 
);

reg clkout = 0;
reg [31:0] cnt = 0;
reg [3:0] scan_cnt = 0;
reg [6:0] Y_reg;
reg [7:0] bit_sel_reg;
reg [2:0] count = 0;

reg [3:0] digit;
reg [3:0] digits1 = 4'b0000, digits2 = 4'b0000, digits3 = 4'b0000, digits4 = 4'b0000, digits5 = 4'b0000, digits6 = 4'b0000;

parameter period = 20000;
parameter CNT_MAX = 25'd20000000;
reg[24:0] Cnt;

assign Y_0 = {Y_reg, 1'b0};
assign Y_1 = {Y_reg, 1'b0};
assign bit_sel = bit_sel_reg;


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        cnt <= 0;
        clkout <= 0;
        end
    else begin
        if(cnt == (period >> 1) - 1) begin
            clkout = ~clkout;
            cnt <= 0;
        end
        else
            cnt <= cnt + 1;
    end
end

always @(posedge clkout or negedge rst_n) begin
    if(!rst_n)
        scan_cnt <= 0;
    else begin
        if(scan_cnt == 4'b1111)
            scan_cnt <= 0;
        else
            scan_cnt <= scan_cnt + 1;
    end
end

always @(scan_cnt) begin
    case(scan_cnt)
        4'b0000: bit_sel_reg = 8'b0000_1000;
        4'b0001: bit_sel_reg = 8'b0001_0000;
        4'b0010: bit_sel_reg = 8'b0010_0000;
        4'b0011: bit_sel_reg = 8'b0100_0000;
        4'b0100: bit_sel_reg = 8'b1000_0000;

        4'b0101: bit_sel_reg = 8'b0000_0001;
        default: bit_sel_reg = 8'b0000_0000;
     endcase
    // case(scan_cnt)
    //     4'b0000: bit_sel_reg = 8'b0000_0001;
    //     4'b0001: bit_sel_reg = 8'b0000_0010;
    //     4'b0010: bit_sel_reg = 8'b0000_0100;
    //     4'b0011: bit_sel_reg = 8'b0000_1000;
    //     4'b0100: bit_sel_reg = 8'b0001_0000;

    //     4'b0101: bit_sel_reg = 8'b0100_0000;
    //     default: bit_sel_reg = 8'b0000_0000;
    //  endcase
end

// always @(posedge clk or negedge rst_n) begin
//     if(!rst_n)
//         Cnt <= 25'd0;
//     else if(switch6 == 1'b1)
//         if(Cnt <= CNT_MAX)
//             Cnt <= Cnt + 1'b1;
//     else
//         Cnt <= 25'd0;
// end

// always @(posedge clk or negedge rst_n) begin
//     if(!rst_n)
//         count <= 1'b0;
//     else if(Cnt == CNT_MAX - 1'b1)
//         if(count == 3'b101)
//            count <= 0;
//         else
//            count <= count + 1;
//     else
//         count <= count;
// end

// always @(posedge switch6) begin
//     if(count == 3'b111)
//         count <= 0;
//     else
//         count <= count + 1;
// end
//

always @(*) begin
    // if (is_duplicated) begin
    //     digits1 = 0;
    //     digits2 = 0;
    //     digits3 = 0;
    //     digits4 = 0;
    //     digits5 = 0;
    //     digits6 = 0;
    // end
    // else begin
        digits1 = num_output[3:0];
        digits2 = num_output[7:4];
        digits3 = num_output[11:8];
        digits4 = num_output[15:12];
        digits5 = num_output[19:16];
        digits6 = times_output;
    // end
end

always @(scan_cnt) begin
    case(scan_cnt)
        0: digit = digits1;
        1: digit = digits2;
        2: digit = digits3;
        3: digit = digits4;
        4: digit = digits5;
        5: digit = digits6;
    endcase
end

always @(scan_cnt) begin
    case(digit)
        4'b0000: Y_reg = 8'b1111_110;
        4'b0001: Y_reg = 8'b0110_000;
        4'b0010: Y_reg = 8'b1101_101;
        4'b0011: Y_reg = 8'b1111_001;
        4'b0100: Y_reg = 8'b0110_011;
        4'b0101: Y_reg = 8'b1011_011;
        4'b0110: Y_reg = 8'b1011_111;
        4'b0111: Y_reg = 8'b1110_000;
        4'b1000: Y_reg = 8'b1111_111;
        4'b1001: Y_reg = 8'b1110_011;
    endcase
end

endmodule