// Given the game_over state and postion for the plane, mountains and lava,
// we can draw the corresponding object in the correct region
module Controller(
	input clk,
	input bright,
	input [9:0] x, //curser for drawing stuff
	input [9:0] y, //curser for drawing stuff
	input [9:0] plane_y,
	input [9:0] mountain1_x,
	input [9:0] mountain1_y,
	input [9:0] mountain2_x,
	input [9:0] mountain2_y,
	input [9:0] lava_x,
	input [9:0] lava_y,
	input game_over,
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue
    );
	
	// Set initial plane_x
	wire [9:0] plane_x;
	assign plane_x = 10'd100;
	
	

	always @ (posedge clk) begin
		// Gaming!
		
		if (~game_over) 
		begin
			if (~bright)
			begin
			   // force black if not bright
				red = 8'b0;
				green = 8'b0;
				blue = 8'b0;
			end	
			else if ((x >= plane_x) && (x <= plane_x + 10'd16) && (y >= plane_y) && (y <= plane_y+10'd16))
			begin
				// draw the blue plane
				red = 8'b0;
				green = 8'b0;
				blue = 8'b11111111;
			end	
			else if (
				((x >= mountain1_x) && (x <= mountain1_x + 10'd30) && ( y >= mountain1_y)) || 
				((x >= mountain2_x) && (x <= mountain2_x + 10'd30) && ( y >= mountain2_y)) 
				)
				begin
				// draw the green mountains
				red = 8'b0;
				green = 8'b11111111;
				blue = 8'b0; 
				end
			else if ((x >= lava_x) && (x <= lava_x + 10'd16) && (y >= lava_y) && (y <= lava_y + 10'd16))
			begin
				// draw the red lava
				red = 8'b11111111;
				green = 8'b0;
				blue = 8'b0;
			end
			else 
			begin
			// background color black
				red = 8'b0;
				green = 8'b0;
				blue = 8'b0;
				end
		end
		
		// Game ends
		else 
			begin
			// force black elsewhere
				red = 8'b00000000;
				green = 8'b00000000;
				blue = 8'b00000000;
			end	
		
	end
endmodule