module pipeline_tb();
parameter N=10;
wire[N-1:0]F;
reg[N-1:0]A,B,C,D;
reg clk;

pipeline MYPIPE(F,A,B,C,D,clk);
initial clk=0;
always #5 clk=~clk;

initial
begin
#5 A=10;B=12;C=6;D=1;
#20 A=30;B=11;C=9;D=24;
end
initial  $monitor("Time=%d, F=%d",$time, F);
endmodule

module pipeline(F,A,B,C,D,clk);
parameter N=10;
input[N-1:0] A,B,C,D;
input clk;
output[N-1:0]F;
reg [N-1:0]F;
reg [N-1:0] L12_x1,L12_x2,L12_D,L23_D,L23_x3,L34_F;

always @(posedge clk)
begin
L12_x1<=#4 A+B;
L12_x2<=#4 C-D;
L12_D<=D;
L23_x3<=#4 L12_x1 + L12_x2;
L23_D<=L12_D;
L34_F<=#6 L23_D * L23_D;
end
endmodule


