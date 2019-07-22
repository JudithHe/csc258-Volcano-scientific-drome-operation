// Part 2 skeleton

module draw
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
		
endmodule

// Plane, moving in vertical direction
module plane(input clk, input resetn, 
input game_over, input[9:0] plane_pos, input up, input down, output reg [9:0] plane_y);
	initial plane_y = plane_pos;
	
	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) plane_y = 9'd0;
			else if (~game_over) begin
				if((up==1) and (plane_y>=9'd12)) plane_y <= plane_y - 9'd8;
				else if ((down==1) and (plane_y<=9'd107)) plane_y <= plane_y + 9'd8;
				else if (plane_y >=9'd107) plane_y <= 9'd107;
				else if (plane_y <=9'd12) plane_y <= 9'd12;
			end// if end
		end// always end 
endmodule

// Lava drops, moving in horizontal direction
module lava(input clk, input resetn, input game_over, input [6:0] score, output reg[9:0] lava_x, output [9:0]lava_y);
	initial lava_x = 9'd155;
	random_generator rand_offset_lava(.clk(clk), .resetn(resetn), .rand_out(lava_y));
	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) lava_x = 9'd155;
			else if (~game_over) begin
				if(lava_x>=9'd12) lava_x <= lava_x - 9'd8;
				else begin
						lava_x <=9'd155;
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
		else temp <= {(temp[3]^temp[1]), temp[2:0], temp[3]};	
	end//always end
	assign rand_out = temp[3:0];
endmodule

//TODO: 2 mountains should have diff random number generator
module mountain(input clk, input resetn, input game_over, 
input [3:0]rand_offset,output reg [3:0]score,output reg[9:0] mountain1_x, 
output reg[9:0] mountain1_y,output reg[9:0] mountain2_x,output reg[9:0] mountain2_y);
	reg[9:0] mountain_y;
	always @(posedge clk, negedge resetn)
		begin
			if (~resetn) begin
				mountain1_x<=9'd70;
				mountain1_y<=9'd50;
				mountain2_x<=9'130;
				mountain2_y<=9'd50;
			end
			else if (~game_over) begin
				mountain_y <= 9'd50+rand_offset;
				mountain1_x <= mountain1_x-9'd10;
				mountain2_x <= mountain1_x-9'd10;
				if (mountain1_x <=9'd60) begin
					mountain1_x <= 9'd130;
					mountain1_y <= mountain_y;
					score <= score +1'd1;
				end
				if (mountain2_x <=9'd60) begin
					mountain2_x <= 9'd130;
					mountain2_y <= mountain_y;
					score <= score +1'd1;
				end
			end// if end
		end// always end 
endmodule