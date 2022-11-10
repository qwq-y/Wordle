module set_digit (
    input switch1, input switch2, input switch3, input switch4, 
    output reg[3:0] temp
);

always@(*) begin
    temp = {switch1, switch2, switch3, switch4};
end

endmodule
