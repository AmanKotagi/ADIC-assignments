module carparking( 
 input clk,reset_n,
 input sensor_entrance, sensor_exit, 
 input [1:0] password_1, 
 output enter,exit
  );
 //parameter IDLE = 3'b000, WAIT_PASSWORD = 3'b001, WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011,STOP = 3'b100;
 parameter IDLE = 2'b00, FRONT = 2'b01, PASS = 2'b10;

 reg[2:0] current_state, next_state;
 reg enter,exit;
 //reg[31:0] counter_wait;
 integer counter_wait=0;
 //reg red_tmp,green_tmp;


 always @(posedge clk or negedge reset_n)
 begin
 if(~reset_n) 
 current_state = IDLE;
 else
 current_state = next_state;
 end

/*
 always @(posedge clk or negedge reset_n) 
 begin
 if(~reset_n) 
 counter_wait <= 0;
 else if(current_state==WAIT_PASSWORD)
 counter_wait <= counter_wait + 1;
 else 
 counter_wait <= 0;
 end
*/

 always @(*)
 begin
 case(current_state)
 IDLE: begin
         if(sensor_entrance == 1)
 next_state = FRONT;
 else
 next_state = IDLE;
 end

 FRONT: begin
 if(password_1 == 2'b01) 
 begin
 enter = 1'b1;
 next_state = PASS;
 counter_wait = 0;
 end
 else 
 begin
 counter_wait = counter_wait + 1;
 if(counter_wait <= 3)
 begin
 next_state = FRONT;
 $display("Password entered is Wrong. %d attempts left", 3-counter_wait);
 end
 else
 begin
 enter = 1'b0;	
 next_state = IDLE; 
counter_wait=0;
 end
 end
 end 

 PASS:  
 begin

 if(sensor_entrance==1 && sensor_exit == 1)
 begin
 exit = 1'b1;
 next_state = IDLE;
 end

 else
 begin
 exit = 0; 
 next_state = IDLE; 
 end

 end 

 default: next_state = IDLE;
 endcase
 end
 endmodule

module tb_parking_system;

  reg clk;
  reg reset_n;
  reg sensor_entrance;
  reg sensor_exit;
  reg [1:0] password_1;
  wire enter;
  wire exit;

  carparking uut (
  .clk(clk), 
  .reset_n(reset_n), 
  .sensor_entrance(sensor_entrance), 
  .sensor_exit(sensor_exit), 
  .password_1(password_1),  
  .enter(enter), 
  .exit(exit)
 );
 initial begin
 clk = 0;
 forever #10 clk = ~clk;
 end
 initial begin

 reset_n = 0;
 sensor_entrance = 0;
 sensor_exit = 0;
 password_1 = 0;

 #100;
      reset_n = 1;
 #20;
 sensor_entrance = 1;
 #1000;
 sensor_entrance = 1;
 password_1 = 0;
 #2000;
 password_1 = 1;
 #2000;
 sensor_exit =1;
 end
 always@(*)
 $monitor("Enter = %b, Exit = %b", enter,exit);
 initial #10000 $finish;     
endmodule



