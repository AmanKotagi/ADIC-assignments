module pipeline2_tb();
reg[3:0] rs1,rs2,rd,func;
reg[7:0]addr;
reg clk1,clk2;
integer k;
pipeline2 dut(zout,rs1,rs2,rd,func,addr,clk1,clk2);
initial
begin
clk1=0;clk2=0;
repeat(20)
begin
#5 clk1=1; #5 clk1=0;
#5 clk2=1; #5 clk2=0;
end
end

initial 
for(k=0;k<16;k=k+1)
dut:regbank(k)
module pipeline2(zout,rs1,rs2,rd,func,addr,clk1,clk2);
input[3:0]rs1,rs2,rd,func;
input[7:0]addr;
input clk1,clk2;
output[15:0]zout;

reg[15:0] l12_a,l12_b,l23_z,l34_z;
reg[3:0] l12_rd,l12_func,l23_rd;
reg[7:0] l12_addr,l23_addr,l34_addr;

reg[15:0] regbank[0:15];
reg[15:0] mem[0:255];

assign zout=l34_z;

always@(posedge clk1)
begin
l12_a<= #2 regbank[rs1];
l12_b<= #2 regbank[rs2];
l12_rd<=rd;
l12_func<=#2 func;
l12_addr<=#2 addr;
end

always @(negedge clk2)
begin
case(func)
0:l23_z<=#2 l12_a+l12_b;
1:l23_z<=#2 l12_a-l12_b;
2:l23_z<=#2 l12_a*l12_b;
3:l23_z<=#2 l12_a;
4:l23_z<=#2 l12_b;
5:l23_z<=#2 l12_a & l12_b;
6:l23_z<=#2 l12_a|l12_b;
7:l23_z<=#2 l12_a^l12_b;
8:l23_z<=#2 -l12_a
9:l23_z<=#2 -l12_b;
10:l23_z<=#2 l12_a>>1;
11:l23_z<=#2 l12_a<<1;
default :L23_z<=#2 16'hxxxx;
endcase
l23_rd<=#2 l12_rd;
l23_addr<=#2 l12_addr;
end


always @(posedge clk1)
begin
regbank[l23_rd]<=#2 l23_z;
l34_addr<= #2 L23_addr

