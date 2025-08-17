`timescale 1ns/1ns
module pipeline_tb;
//PORTS
	parameter INP_WIDTH = 2, OUT_WIDTH = 4;
	logic clk;
	logic rst; 
	logic stall;                      // added stall signal
	logic [INP_WIDTH-1:0]A, B, C; 
	logic [OUT_WIDTH-1:0]X;

//INSTANTIATION OF DUT
pipeline #(
	.INP_WIDTH(INP_WIDTH), 
	.OUT_WIDTH(OUT_WIDTH)
	)
dut_tb(
	.clk(clk),
	.rst(rst), 
	.stall(stall),                  // connect stall
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
stall = 0;

@(posedge clk); 
rst = 1;

//test case 1 (normal operation)
A = 0; B = 0; C = 0;
@(posedge clk); 
A = 1; B = 1; C = 1;
@(posedge clk);
A = 0; B = 0; C = 0;

// let pipeline run freely for a while
repeat (3) @(posedge clk);

// test case 2 (STALL active)
A = 2; B = 2; C = 2;
@(posedge clk);
stall = 1;                       // freeze pipeline
             					 // should be ignored while stall=1
repeat (2) @(posedge clk);       // hold stall for 3 cycles

// release stall
stall = 0;
A=0; B=0; C=0;
@(posedge clk);

// apply new input after stall release
A = 3; B = 1; C = 2;
@(posedge clk);
A = 0; B = 0; C = 0;

repeat (5) @(posedge clk);
$finish;

end
endmodule
