module temp (
    input switch5, input switch6,
    input [3:0] temp,   // a digit from 1~4th
    input [1:0] state,  
    output reg[19:0] num_output,    // for 7-seg    
    output reg[3:0] times_output,     // for 7-seg
    output reg[2:0] led1, led2, led3, led4, led5,    // for LED
    output reg warning  
);


reg[19:0] num_temp = 0;    // store, before check duplication
reg[19:0] num;
reg[19:0] num_guess;
reg[3:0] times_temp = 0;
reg[3:0] times_guess = 0;
reg[2:0] i = 0;    // pointer of the num digits
reg is_duplicated = 0;
reg[3:0] t1, t2, t3, t4, t5;


always@(*) begin
    if (is_duplicated == 1) begin
        warning = 1;
    end
    else begin
        warning = 0;
    end
end

always@(*) begin    // output of num (for 7-seg)
    num_output = num_temp;
    times_output = times_temp - times_guess;
end


always@(num_guess) begin    // update times_guess, decide led
    if (state == 1) begin    // initialize
        times_guess <= 0;
        led1 <= 1;
        led2 <= 1;
        led3 <= 1;
        led4 <= 1;
        led5 <= 1;
    end
    else begin
        if (state == 3) begin    // update times_guess, decide led
            times_guess = times_guess + 1;                          
            // LED
            // compare digit by digit
            case(num_guess[3:0])    // num_guess is the guess value
                num[3:0]: led1 <= 3'b100;    // num is the set value
                num[7:4]: led1 <= 3'b010;
                num[11:8]: led1 <= 3'b010;
                num[15:12]: led1 <= 3'b010;
                num[19:16]: led1 <= 3'b010;
                default led1 <= 3'b001;
            endcase

            case(num_guess[7:4])
                num[3:0]: led3 <= 3'b010;
                num[7:4]: led3 <= 3'b100;
                num[11:8]: led3 <= 3'b010;
                num[15:12]: led3 <= 3'b010;
                num[19:16]: led3 <= 3'b010;
                default  led3 <= 3'b001;
            endcase

            case(num_guess[11:8])
                num[3:0]: led3 <= 3'b010;
                num[7:4]: led3 <= 3'b010;
                num[11:8]: led3 <= 3'b100;
                num[15:12]: led3 <= 3'b010;
                num[19:16]: led3 <= 3'b010;
                default  led3 <= 3'b001;
            endcase

            case(num_guess[15:12])
                num[3:0]: led4 <= 3'b010;
                num[7:4]: led4 <= 3'b010;
                num[11:8]: led4 <= 3'b010;
                num[15:12]: led4 <= 3'b100;
                num[19:16]: led4 <= 3'b010;
                default led4 <= 3'b001;
            endcase

            case(num_guess[19:16])
                num[3:0]: led5 <= 3'b010;
                num[7:4]: led5 <= 3'b010;
                num[11:8]: led5 <= 3'b010;
                num[15:12]: led5 <= 3'b010;
                num[19:16]: led5 <= 3'b100;
                default led5 <= 3'b001;
            endcase
        end
    end
end


always@(posedge switch5) begin    
    if (state == 1) begin
        num <= 0;
        num_guess <= 0;
        num_temp <= 0;
        times_temp <= 0;
    end
    else begin
        if (switch6) begin    // read in as times
            if (0 <= temp && temp <= 9) begin
                times_temp <= temp;
            end 
        end
        else begin    // read in as num
            if (0 <= temp && temp <= 9) begin
                i = i + 1;
                num_temp = {num_temp[15:0], temp[3:0]};
                if (i >= 5) begin

                    // check if the whole five digit is valid
                    is_duplicated = 0;                                        

                    t1 = num_temp >> 0;    // shift operator
                    t2 = num_temp >> 4;
                    t3 = num_temp >> 8;
                    t4 = num_temp >> 12;
                    t5 = num_temp >> 16;

                    if ((t1==t2)||(t1==t3)||(t1==t4)||(t1==t5)||(t2==t3)||
                    (t2==t4)||(t2==t5)||(t3==t4)||(t3==t5)||(t4==t5)) begin
                        is_duplicated = 1;
                    end
                    else begin
                        if (state == 2) begin
                            num = num_temp;
                        end
                        else if (state == 3) begin
                            num_guess = num_temp;
                        end
                    end

                    i = 0;
                end
            end
        end
    end
end

endmodule
