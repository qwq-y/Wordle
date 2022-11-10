module LED (
    input clk,
    input rst_n,
    input [2:0] led1,
    input [2:0] led2,
    input [2:0] led3,
    input [2:0] led4,
    input [2:0] led5,
    input[1:0] state,
    input warning,
    output reg led1_out, led2_out, led3_out, led4_out, led5_out,
    output reg led6_out,
    output reg led7_out, led8_out
);

reg led;
parameter CNT_MAX = 25'd20000000;
reg[24:0] cnt;

always @(warning) begin
    if (warning == 1) begin
        led6_out = 1;
    end
    else begin
        led6_out = 0;
    end
end

always @(state) begin
    case (state)
        1: begin
            led7_out = 0;
            led8_out = 1;
        end
        2: begin
            led7_out = 1;
            led8_out = 0;
        end
        3: begin
            led7_out = 1;
            led8_out = 1;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt <= 25'd0;
    else begin
        if(cnt <= CNT_MAX)
            cnt <= cnt + 1'b1;
        else 
            cnt <= 25'd0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(led1 == 3'b100) 
        led1_out = 1'b1;
    else if(led1 == 3'b001) begin
        led1_out = 1'b0;
    end
    else if(led1 == 3'b010) begin
        if(!rst_n)
            led1_out <= 1'b0;
        else if(cnt == CNT_MAX - 1'b1)
            led1_out <= ~led1_out;
        else
            led1_out <= led1_out;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(led2 == 3'b100) 
        led2_out = 1'b1;
    else if(led2 == 3'b001) begin
        led2_out = 1'b0;
    end
    else if(led2 == 3'b010) begin
        if(!rst_n)
            led2_out <= 1'b0;
        else if(cnt == CNT_MAX - 1'b1)
            led2_out <= ~led2_out;
        else
            led2_out <= led2_out;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(led3 == 3'b100) 
        led3_out = 1'b1;
    else if(led3 == 3'b001) begin
        led3_out = 1'b0;
    end
    else if(led3 == 3'b010) begin
        if(!rst_n)
            led3_out <= 1'b0;
        else if(cnt == CNT_MAX - 1'b1)
            led3_out <= ~led3_out;
        else
            led3_out <= led3_out;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(led4 == 3'b100) 
        led4_out = 1'b1;
    else if(led1 == 3'b001) begin
        led4_out = 1'b0;
    end
    else if(led4 == 3'b010) begin
        if(!rst_n)
            led4_out <= 1'b0;
        else if(cnt == CNT_MAX - 1'b1)
            led4_out <= ~led4_out;
        else
            led4_out <= led4_out;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(led5 == 3'b100) 
        led5_out = 1'b1;
    else if(led5 == 3'b001) begin
        led5_out = 1'b0;
    end
    else if(led5 == 3'b010) begin
        if(!rst_n)
            led5_out <= 1'b0;
        else if(cnt == CNT_MAX - 1'b1)
            led5_out <= ~led5_out;
        else
            led5_out <= led5_out;
    end
end

endmodule //LED