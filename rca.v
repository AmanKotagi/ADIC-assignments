module rca_tb();
reg [3:0]a,b;
reg cin;
wire cout;
wire [3:0]s;
wire [2:0]c;

rca dut(a,b,cin,s,cout);
initial begin
a=4'b0000;
b=4'b0000;
cin=0;
end

always #20 a=a+4'b0001;
always #20 b=b+4'b0001;
always #20 cin=cin+1'b1;


endmodule




module rca(a,b,cin,s,cout);
input[3:0]a,b;
input cin;
output cout;
output [3:0]s;
wire[2:0]c;

assign s[0]=a[0]^b[0];
assign c[0]=(a[0]&b[0])|(b[0]&cin)|(cin&a[0]);
assign s[1]=a[1]^b[1]^c[0];
assign c[1]=(a[1]&b[1])|(b[1]&c[0])|(c[0]&a[1]);
assign s[2]=a[2]^b[2]^c[1];
assign c[2]=(a[2]&b[2])|(b[2]&c[1])|(c[1]&a[2]);
assign s[3]=a[3]^b[3]^c[2];
assign cout=(a[3]&b[3])|(b[3]&c[2])|(c[2]&a[3]);
endmodule
