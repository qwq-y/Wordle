module top (
    input switch1, input switch2, input switch3, input switch4,
    input switch5, input switch6, input switch7, input switch8,
    input clk,
    input rst_n,
    output[7:0] bit_sel, 
    output[7:0] Y_0, 
    output[7:0] Y_1,
    output led1_out, output led2_out, output led3_out, 
    output led4_out, output led5_out, 
    output led6_out,     // warning
    output led7_out, output led8_out    // state
);


wire[2:0] led1;
wire[2:0] led3;
wire[2:0] led4;
wire[2:0] led2;
wire[2:0] led5;

wire[1:0] state;
wire[3:0] temp;
wire warning;

wire[19:0] num_output;
wire[3:0] times_output;


state_switcher state_switcher_0 (switch7, switch8, state);
set_digit set_digit_0 (switch1, switch2, switch3, switch4, temp);
read_in read_in_0 (switch5, switch6, temp, state, num_output, times_output, led1, led2, led3, led4, led5, warning);
seven_segment seven_segment_0 (num_output, times_output, clk, rst_n, bit_sel, Y_0, Y_1);
LED LED_0 (clk, rst_n, led1, led2, led3, led4, led5, state, warning, led1_out, led2_out, led3_out, led4_out, led5_out, led6_out, led7_out, led8_out);

endmodule

