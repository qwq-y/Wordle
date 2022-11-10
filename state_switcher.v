module state_switcher (
    input switch7, input switch8, 
    output reg[1:0] state
);

always@(*) begin
    state = {switch7, switch8};
end

endmodule
