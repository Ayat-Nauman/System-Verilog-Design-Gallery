module pipeline (
input logic clk, rst, 
input logic [9:0]A, B, C, 
output logic [13:0]X 
);

logic [9:0] D = 1; //768 is equivalent to 10 bits 
logic [40:0] FF1;
logic [30:0] FF2;
logic [20:0] FF3 ; // Pipeline registers
logic [10:0] stage1_out, stage2_out, stage3_out; //outputs of stage 1, stage 2, and stage 3

//STAGE 1
always_ff @(posedge clk or negedge rst) begin
	if (!rst) begin
	FF1 <= '0;
	stage1_out <= 0;
	end else begin
	stage1_out <= (A << 2)+ A; //4A + A = 5A = STAGE 1
	FF1 <= {stage1_out, B, C, D}; //FF1[40:30] = stage1_out, FF1[29:20] = B, FF1[19:10] = C, FF1[9:0] = D
	end
end
//STAGE 2
always_ff @(posedge clk or negedge rst) begin
	if (!rst) begin
	FF2 <= '0;
	stage2_out <= 0;
	end else begin
	stage2_out <= FF1[40:30]+ ((FF1[29:20] << 2) + FF1[29:20]); //5A + 4B + B = 5A + 5B = STAGE 2
	FF2 <= {stage2_out, FF1[19:10], FF1[9:0]}; //FF2[30:20] = stage2_out, FF2[19:10] = C, FF2[9:0] = D
	end
end
//STAGE 3
always_ff @(posedge clk or negedge rst) begin
	if (!rst) begin
	FF3 <= '0;
	stage3_out <= 0;
	end else begin
	stage3_out <= FF2[30:20] - (FF2[19:10] << 2); // 5A + 5B - 4C = STAGE 3
	FF3 <= {stage3_out, FF2[9:0]}; //FF3[20:10] = stage3_out, FF3[9:0] = D
	end
end


//STAGE 4
assign X = FF3[20:10] + (FF3[9:0] + (FF3[9:0]<<1)); // 5A + 5B - 4C + (2D + D) = X(OUTPUT)

endmodule
