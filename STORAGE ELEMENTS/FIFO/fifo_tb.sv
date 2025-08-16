// set the timesccale
`timescale 1ns/1ns

//Tb module declaration
module fifo_chipverify_tb;
	parameter DEPTH = 8, WIDTH = 8;
	logic clk, rstn, push, pop;
	logic [WIDTH-1:0] write;
	logic full, empty;
	logic [WIDTH-1:0] read;

//DUT instantiation
fifo_chipverify #(
.DEPTH(DEPTH), 
.WIDTH(WIDTH)
) 

DUT (
.clk(clk),
.rstn(rstn),
.pop(pop),
.push(push),
.write(write),
.full(full),
.empty(empty),
.read(read)
);

//Clock setting
always begin
clk = ! clk;
#5;
end

// test cases
initial begin

//test case 1: assert reset
clk  = 1'b1;
rstn = 1'b0;
push = 1'b0;
pop  = 1'b0;
#20;
// test case 2:
rstn = 1'b1; // release reset
push = 1; write = 8'h0; 
@(posedge clk); write = 8'h1;
@(posedge clk); write = 8'h2;
@(posedge clk); write = 8'h3;
@(posedge clk); push = 0;
@(posedge clk);
pop = 1;
repeat(4) @(posedge clk);
pop = 0;
#30;
$finish;
end

endmodule