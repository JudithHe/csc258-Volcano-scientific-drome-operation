// Plane, moving in vertical direction
module plane(input clk, input resetn, 
input game_over,  input up, input down, output reg [9:0] plane_y);
	initial plane_y = 9'd50;

	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) plane_y <= 9'd50;
			else if (~game_over)//game_over = 0 means game continues
			begin
				if((up==1) &&(plane_y>=9'd40)) plane_y <= plane_y - 9'd8; // 40 is upper bound of the active drawing region
				else if ((down==1) &&(plane_y<=9'd400)) plane_y <= plane_y + 9'd8;// 400 is lower bound
				else if (plane_y >=9'd400) plane_y <= 9'd400;
				else if (plane_y <=9'd40) plane_y <= 9'd40;
			end// if end
		end
endmodule

// Lava drops, moving in horizontal direction
module lava(input clk, input resetn, input game_over, output reg[6:0]score, output reg [9:0]lava_x);
	
	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) lava_x <= 9'd550;
			else if (~game_over) 
				begin
					lava_x <= lava_x - 9'd10;
					if (lava_x <= 9'd60)begin
							lava_x <= 9'd550;
							score <= score +1'd1;
						end
				end// if end
		end// always end 
endmodule

module random_generator(input clk, input resetn, output [3:0] rand_out);
	reg [3:0] temp;
	always @(posedge clk, negedge resetn)
	begin 
		if (~resetn) temp <= 4'hf; 
		else temp <= {(temp[3]^temp[1]), temp[1:0], temp[3]};	
	end//always end
	assign rand_out = temp[3:0];
endmodule

//TODO: 2 mountains should have diff random number generator
module mountain(input clk, input resetn, input game_over, 
	output reg [3:0]score,output reg[9:0] mountain1_x, 
	output reg[9:0] mountain1_y,output reg[9:0] mountain2_x,output reg[9:0] mountain2_y);
	reg[9:0] mountain_y;
	wire[3:0] rand_offset;
	
	random_generator random(.clk(clk),.resetn(resetn),.rand_out(rand_offset));
	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) begin
				mountain1_x<=9'd300;
				mountain1_y<=9'd150;
				mountain2_x<=9'd500;
				mountain2_y<=9'd150;
			end
			else if (~game_over) //if game continues
				begin
					mountain_y <= 9'd150+rand_offset;
					mountain1_x <= mountain1_x-9'd10;
					mountain2_x <= mountain2_x-9'd10;
				if (mountain1_x <=9'd60) begin
					mountain1_x <= 9'd500;
					mountain1_y <= mountain_y;
					score <= score +1'd1;
				end
				if (mountain2_x <=9'd60) begin
					mountain2_x <= 9'd500;
					mountain2_y <= mountain_y;
					score <= score +1'd1;
				end
			end// if end
		end// always end 
endmodule