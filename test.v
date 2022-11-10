module test (
    input switch5, input switch6, 
    input [3:0] temp,   // a digit from 1~4th
    input [1:0] state,  
    output wire is_ready,    // if times and nums are all setted
    output reg[19:0] num_output,    
    output reg[3:0] times_output,
    output reg is_win,
    output reg is_over,
    output reg[1:0] led0_in, led1_in, led2_in, led3_in, led4_in
);
 
// state2
reg[2:0] i;    // count ?/5 have been read
reg[3:0] times;    // assignment
reg[19:0] num;    // assignment (4*5=20bits)

reg[3:0] times_temp;    // store
reg[19:0] num_temp;    // store
reg is_times_settled;
reg is_nums_settled;   

// state3
reg[2:0] guess_i;
reg[3:0] guess_times;
reg[19:0] guess_num;


assign is_ready = is_times_settled && is_nums_settled;

// initializzation
always@(state or num or times or guess_num or guess_times) begin
    case(state)
        1:begin
            i = 0;
            num = 0;
            num_temp = 0;
            times = 0;
            times_temp = 0;

            is_duplicated = 0;
            is_full = 1;
            is_times_settled = 0;
            is_nums_settled = 0;

            guess_i = 0;
            guess_times = 0;
            guess_num = 0; 

            is_win = 0;
            is_over = 0;  
        end
        2:begin
            num_output = num;
            times_output = times;
        end
        3:begin
            num_output = guess_num;
            times_output = times - guess_times;
        end
    endcase
end


// function: check if one digit is valid; store
always@(posedge switch5) begin
    begin
        case(state)
            2:begin
                if (0 <= temp && temp <= 9) begin
                    if (switch6) begin    
                        times_temp <= temp;
                    end
                    else begin
                    if (i < 5) begin
                    i <= i + 1;
                    num_temp <= {num_temp[15:0], temp[3:0]};    // concatenation operator
                    end
                    end
                end
            end

            3:begin
                if (0 <= temp && temp <= 9) begin
                    if (guess_i < 5) begin
                        guess_i <= guess_i + 1;
                        guess_num <= {guess_num[15:0], temp[3:0]};
                    end
                end
            end
        endcase
    end
end


reg[3:0] t1, t2, t3, t4, t5;
reg is_duplicated;   
reg is_full; 

// function: check if the whole five digits is valid; assignment num
always@(posedge switch6) begin
   case(state)
       2:begin
           is_duplicated <= 0;
           is_full <= 1;

           t1 <= num >> 0;    // shift operator
           t2 <= num >> 4;
           t3 <= num >> 8;
           t4 <= num >> 12;
           t5 <= num >> 16;

           if (i < 5) begin
               is_full <= 0;
           end

           if ((t1==t2)||(t1==t3)||(t1==t4)||(t1==t5)||(t2==t3)||
           (t2==t4)||(t2==t5)||(t3==t4)||(t3==t5)||(t4==t5)) begin
               is_duplicated <= 1;
           end

           if (is_duplicated == 0 && is_full == 1) begin
               num <= num_temp;
               is_nums_settled <= 1;                                 
           end     
       end

       3:begin
           is_duplicated <= 0;
           is_full <= 1;

           t1 <= guess_num >> 0;    // shift operator
           t2 <= guess_num >> 4;
           t3 <= guess_num >> 8;
           t4 <= guess_num >> 12;
           t5 <= guess_num >> 16;

           if (guess_i < 5) begin
               is_full <= 0;
           end

           if ((t1==t2)||(t1==t3)||(t1==t4)||(t1==t5)||(t2==t3)||
           (t2==t4)||(t2==t5)||(t3==t4)||(t3==t5)||(t4==t5)) begin
               is_duplicated <= 1;
           end

           if (is_duplicated == 0 && is_full == 1) begin
               guess_times <= guess_times + 1;
               if (guess_num == num) begin    // correct guess
                   is_win <= 1;
                   is_over <= 1;
               end              
               else begin
                   if (guess_times >= times) begin    
                       is_over <= 1;
                   end
               end           
           end     
       end
   endcase
end


// assignment times
always@(negedge switch6) begin
    // case(state)
    //     2:begin
            times <= times_temp;
            is_times_settled <= 1;
    //     end
    // endcase
end

endmodule



module test_tb();

reg switch5;
reg switch6;
reg[3:0] temp;
reg[1:0] state;
wire is_ready;
wire[19:0] num_output;
wire[3:0] times_output;
wire is_win;
wire is_over;
wire[1:0] led0_in, led1_in, led2_in, led3_in, led4_in;
reg[2:0] count = 3'b000;

test test_0 (switch5, switch6, temp, state, is_ready, num_output, times_output, is_win, is_over, led0_in, led1_in, led2_in, led3_in, led4_in);

initial begin
    $dumpfile("test_wave.vcd");
    $dumpvars;
    $display(times_output);
    while (count < 3'b111) begin
        state = 1;

        #10 count = count + 1;
        state = 2;
        temp = 0;
        switch5 = 0;
        switch6 = 0;
        $display(times_output, num_output);

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 1;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 2;
        
        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 3;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 4;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 5;

        #10 switch6 = 1;
        $display(times_output, num_output);

        #10 temp = 6;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);


        #10 state = 3;
        temp = 0;
        switch5 = 0;
        switch6 = 0;
        $display(times_output, num_output);

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 1;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 2;
        
        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 3;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 4;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 temp = 5;

        #10 switch6 = 1;
        $display(times_output, num_output);

        #10 temp = 6;

        #10 switch5 = 1;
        $display(times_output, num_output);

        #10 switch5 = 0;
        $display(times_output, num_output);

        #10 switch6 = 0;
        $display(times_output, num_output);

    end
end


endmodule
