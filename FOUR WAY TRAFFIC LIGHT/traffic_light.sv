module traffic_light #(parameter time_a = 1, time_b = 2, time_c = 3, time_d = 4
)(
input clk, // Clock
input rst, // Active low Reset 
input logic switch_to_a, //switch to control Traffic light of road A
input logic switch_to_b, //switch to control Traffic light of road B
input logic switch_to_c, //switch to control Traffic light of road C
input logic switch_to_d, //switch to control Traffic light of road D
output logic [4-1:0] light_en // Bus of width = 4 bit(0,1,2,3) 
//where 0 = Traffic light of road A
// 1 = Traffic light of road B 
// 2 = Traffic light of road C 
// 3 = Traffic light of road D
);

// counter initializations
logic [2:0]counter = 3'b000;

// state definition
typedef enum logic[2:0]{STATE_A, STATE_B, STATE_C, STATE_D} transition_states;
transition_states current_state, next_state;

// State Register
always_ff @(posedge clk or negedge rst) begin
	if(!rst) 
        	current_state <= STATE_A; //default assignment
	else 
		current_state <= next_state; //storing next state in the flip flop - updating the states
end


//State transition logic on the basis of current state and inputs
always_comb begin 
    next_state = current_state ;
    if (switch_to_a && counter == 0) next_state = STATE_A ;
    else if (switch_to_b && counter == 0) next_state = STATE_B ;
    else if (switch_to_c && counter == 0) next_state = STATE_C ;
    else if (switch_to_d && counter == 0) next_state = STATE_D ;
end 


//counter block
always_ff @ (posedge clk or negedge rst) begin
	if(!rst) counter <= 0;
	else begin

	case (current_state)
	STATE_A: begin
	if(counter == (time_a - 1)) counter <= 0;
	else counter <= counter + 1;
	end
	
	STATE_B: begin
	if(counter == (time_b - 1)) counter <= 0;
	else counter <= counter + 1;
	end

	STATE_C: begin
	if(counter == (time_c - 1)) counter <= 0;
	else counter <= counter + 1;
	end

	STATE_D: begin
	if(counter == (time_d - 1)) counter <= 0;
	else counter <= counter + 1;
	end
	
	endcase

	end
end

always_ff @(posedge clk or negedge rst) begin
	if(!rst) light_en = 4'b1000;
	case(current_state)
		STATE_A: light_en = 4'b1000; // light A
		STATE_B: light_en = 4'b0100; // light B
		STATE_C: light_en = 4'b0010; // light C
		STATE_D: light_en = 4'b0001; // light D
	endcase
end

endmodule

