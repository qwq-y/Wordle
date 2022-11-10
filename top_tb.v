`include "set_digit.v"
`include "state_switcher.v"
`include "read_in.v"
`include "seven_segment.v"
`include "LED.v"
`include "top.v"


module top_tb();

reg switch1, switch2, switch3, switch4;
reg switch5, switch6, switch7, switch8;
reg clk;
reg rst_n;
wire warning;
wire[7:0] bit_sel;
wire[7:0] Y_0;
wire[7:0] Y_1;
wire led1_out, led2_out, led3_out, led4_out, led5_out, led6_out, led7_out, led8_out;
reg[2:0] count = 3'b000;

top top_0 (switch1,switch2,switch3,switch4,switch5,switch6,switch7,switch8,
clk,rst_n,bit_sel,Y_0,Y_1,led1_out, led2_out, led3_out, led4_out, led5_out,led6_out, led7_out, led8_out);

initial begin
   $dumpfile("top_wave_0.vcd");
   $dumpvars;
   $display(bit_sel);

   clk = 0;

   while (count < 3'b011) begin

       // initialize, get into state 2
       #10 count = count + 1;
       switch1 = 0;
       switch2 = 0;
       switch3 = 0;
       switch4 = 0;
       switch5 = 0;
       switch6 = 0;
       switch7 = 1;
       switch8 = 0;
       $display(bit_sel);

       // input 1st: 4
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 0;
       $display(bit_sel);

       // read in 4 as times
       #10 
       switch6 = 1;
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 2nd: too large (false!!)
       #10 
       switch1 = 1;
       switch2 = 1;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in it as num
       #10 
       switch6 = 0;
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 2nd: 2
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in 2 as num (1)
       #10 
       switch6 = 0;
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);
      

       // input 3th: 3
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in 3 as num (2)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 4th: 4
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 0;
       $display(bit_sel);

       // read in 4 as num (3)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 5th: 5
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 1;
       $display(bit_sel);

       // read in 5 as num (4)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 6 th: 6
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 1;
       switch4 = 0;
       $display(bit_sel);

       // read in 6 as num (5)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);





      
      // state3 first guess

      #10
      switch7 = 1;
      switch8 = 1;
      switch6 = 1;

      // // input 1st: 1  
      //  #10 
      //  switch1 = 0;
      //  switch2 = 0;
      //  switch3 = 0;
      //  switch4 = 1;
      //  $display(bit_sel);

      //  // read in 1 as times
      //  #10 
      //  switch6 = 1;
      //  switch9 = 1;
      //  switch5 = 1;
      //  $display(bit_sel);
      //  #10 
      //  switch5 = 0;
      //  $display(bit_sel);


       // input 2nd: 2
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 0;
       $display(bit_sel);

       // read in 2 as num (1)
       #10 
       switch6 = 0;
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);
      

       // input 3th: 3
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in 3 as num (2)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 4th: 4
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 0;
       $display(bit_sel);

       // read in 4 as num (3)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 5th: 5
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in 5 as num (4)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 6 th: 6
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 1;
       switch4 = 0;
       $display(bit_sel);

       // read in 6 as num (5)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);







       // state3 second guess

      #10
      switch7 = 1;
      switch8 = 1;
      switch6 = 1;

      // // input 1st: 1  
      //  #10 
      //  switch1 = 0;
      //  switch2 = 0;
      //  switch3 = 0;
      //  switch4 = 1;
      //  $display(bit_sel);

      //  // read in 1 as times
      //  #10 
      //  switch6 = 1;
      //  switch9 = 1;
      //  switch5 = 1;
      //  $display(bit_sel);
      //  #10 
      //  switch5 = 0;
      //  $display(bit_sel);


       // input 2nd: 2
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 0;
       $display(bit_sel);

       // read in 2 as num (1)
       #10 
       switch6 = 0;
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);
      

       // input 3th: 3
       #10 
       switch1 = 0;
       switch2 = 0;
       switch3 = 1;
       switch4 = 1;
       $display(bit_sel);

       // read in 3 as num (2)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 4th: 4
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 0;
       $display(bit_sel);

       // read in 4 as num (3)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 5th: 5
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 0;
       switch4 = 1;
       $display(bit_sel);

       // read in 5 as num (4)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);


       // input 6 th: 6
       #10 
       switch1 = 0;
       switch2 = 1;
       switch3 = 1;
       switch4 = 0;
       $display(bit_sel);

       // read in 6 as num (5)
       #10 
       switch5 = 1;
       $display(bit_sel);
       #10 
       switch5 = 0;
       $display(bit_sel);



       // state 1
       #10 
       switch7 = 0;
       switch8 = 1;
       switch5 = 1;
       $display(bit_sel);
       #10
       switch5 = 0;
       $display(bit_sel);



   end
end


endmodule