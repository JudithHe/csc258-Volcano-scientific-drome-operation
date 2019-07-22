module VGA_Bitgen(
	 input clk,
    input bright,
    input [9:0] x,
    input [9:0] y,
	 input [9:0] plane_y_pos,
	 input [9:0] tube1_x_pos,
	 input [9:0] tube1_y_pos,
	 input [9:0] tube2_x_pos,
	 input [9:0] tube2_y_pos,
	 input [9:0] tube3_x_pos,
	 input [9:0] tube3_y_pos,
	 input game_end,
	 input [7:0] score,
     output reg [7:0] red,
	 output reg [7:0] green,
	 output reg [7:0] blue
    );
	
	// Set plane_x_pos
	wire [9:0] plane_x_pos;
	assign plane_x_pos = 10'd180;
	
	// For score display
	reg [3:0] dig_2;
	reg [3:0] dig_1;
	reg [3:0] dig_0;
	reg Dig0Seg0, Dig0Seg1, Dig0Seg2, Dig0Seg3, Dig0Seg4, Dig0Seg5, Dig0Seg6;
	reg Dig1Seg0, Dig1Seg1, Dig1Seg2, Dig1Seg3, Dig1Seg4, Dig1Seg5, Dig1Seg6;
	reg Dig2Seg0, Dig2Seg1, Dig2Seg2, Dig2Seg3, Dig2Seg4, Dig2Seg5, Dig2Seg6;
	reg digit_display_2, digit_display_1, digit_display_0;
	
	always @ (posedge clk) begin
		// Gaming!
		if (~game_end) 
		begin
			if (~bright)
			begin
			   // force black if not bright
				red = 8'b0;
				green = 8'b0;
				blue = 8'b0;
			end	
			else if ((x >= plane_x_pos - 10'd15) && (x <= plane_x_pos + 10'd15) && (y >= plane_y_pos - 10'd15) && (y <= plane_y_pos + 10'd15))
			begin
				// draw the blue plane
				red = 8'b0;
				green = 8'b0;
				blue = 8'b11111111;
			end	
			else if (
				((x >= tube1_x_pos - 10'd30) && (x <= tube1_x_pos + 10'd30) && ((y >= tube1_y_pos + 10'd35) || (y <= tube1_y_pos - 10'd35))) || 
				((x >= tube2_x_pos - 10'd30) && (x <= tube2_x_pos + 10'd30) && ((y >= tube2_y_pos + 10'd35) || (y <= tube2_y_pos - 10'd35))) 
				)
				begin
				// draw the green tubes
				red = 8'b0;
				green = 8'b11111111;
				blue = 8'b0; 
				end
			else if((x >= lava_x_pos - 10'd15) && (x <= lava_x_pos + 10'd15) && (y >= lava_y_pos - 10'd15) && (y <= lava_y_pos + 10'd15))
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