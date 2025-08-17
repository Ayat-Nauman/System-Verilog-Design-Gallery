// X = 5A + 5B - 4C + 3D
module pipeline #(parameter 
	OUT_WIDTH = 4, 
	INP_WIDTH = 2
	)(
	input logic clk, rst, stall,    // Clock, reset, stall
	input logic [INP_WIDTH-1:0] A, B, C, 
	output logic [OUT_WIDTH-1:0] X
	
);

logic [INP_WIDTH-1:0] D = 1;
// STAGE 1 PIPELINE REGISTERS
logic [(INP_WIDTH + 3)-1:0] stage1_out;		//5A
logic [INP_WIDTH-1:0] stage1_B, stage1_C;

// STAGE 2 PIPELINE REGISTERS
logic [(INP_WIDTH + 4)-1:0] stage2_out;		//5A + 5B
logic [INP_WIDTH-1:0] stage2_C;

// STAGE 3 PIPELINE REGISTERS
logic [(INP_WIDTH + 4)-1:0] stage3_out;		//5A + 5B - 4C


// STAGE 1 
always_ff @(posedge clk or negedge rst) begin
	if(~rst) begin
		stage1_out <= 0;
		stage1_B <= 0;
		stage1_C <= 0;
	end else if (~stall) begin
		stage1_out <= (A<<2) + A; 		//5A
		stage1_B   <= B;
		stage1_C   <= C;
	end
end

// STAGE 2
always_ff @(posedge clk or negedge rst) begin 
	if(~rst) begin
		stage2_out <= 0;
		stage2_C   <= 0;
	end else if (~stall) begin
		stage2_out <= stage1_out + (stage1_B<<2) + stage1_B; // 5A + 4B + B
		stage2_C <= stage1_C;
	end
end

// STAGE 3
always_ff @(posedge clk or negedge rst) begin 
	if(~rst) begin
		stage3_out <= 0;
	end else if (~stall) begin
		stage3_out <= stage2_out - (stage2_C << 2); //5A + 5B - 4C
	end
end

// STAGE 4
assign X = stage3_out + (D << 1) + D; 
endmodule : pipeline