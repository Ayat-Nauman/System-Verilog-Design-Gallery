`timescale 1ns/1ns
module pipeline_tb;
//PORTS
	logic clk;
	logic rst; 
	logic [9:0]A, B, C; 
	logic [13:0]X;

//INSTANTIATION OF DUT
pipeline dut_tb(
	.clk(clk),
	.rst(rst), 
	.A(A),
	.B(B),
	.C(C), 
	.X(X)
); 

//CLOCK SETTING
always begin
 clk = !clk; //TimePeriod = 10ns
 #5;
end

initial begin
//DRIVING STIMULUS
clk = 1;
rst = 0;
#20;

//test case 1
rst = 1;
A=1;
B=1;
C=1;
#80;
$finish;

end
endmodule
