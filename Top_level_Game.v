module Game(
    // Global clock (50MHz)
	input CLOCK_50,
	// Button control(resetn, up and down)
    input [1:0] KEY,
	// VGA display
    output VGA_HS,
    output VGA_VS,
    output [7:0] VGA_R, VGA_G, VGA_B,
	output [6:0] HEX2, HEX1, HEX0,
	output VGA_BLANK_N,
	output VGA_SYNC_N,
	output VGA_CLK
    );
	
	wire [9:0] x;
	wire [9:0] y;
	wire clk10;
	wire [9:0] plane_y;
	wire [9:0] mountain1_x;
	wire [9:0] mountain1_y;
	wire [9:0] mountain2_x;
	wire [9:0] mountain2_y;
	wire [9:0] lava_x;
	wire [9:0] lava_y;
	wire game_over;
	wire [7:0] score;
	wire bright;
	wire vgaclk;
	
	// graphics
	assign VGA_CLK=vgaclk;
	assign VGA_BLANK_N=1'b1;
	assign VGA_SYNC_N=1'b1;
	wire isdisplay;
	wire [9:0] drawX,drawY;
	
	VGA_Controller synchGen(
		.clk(vgaclk),
		.resetn(KEY[1]),
		.vga_HS(VGA_HS),
		.vga_VS(VGA_VS),
		.X(drawX),
		.Y(drawY),
		.display(isdisplay)
		);
	
	Controller c0(
		.clk(vgaclk),
		.bright(isdisplay),
		.x(drawX),
		.y(drawY),
		.plane_y(plane_y),
	    .mountain1_x(mountain1_x),
		.mountain1_y(mountain1_y),
		.mountain2_x(mountain2_x),
		.mountain2_y(mountain2_y),
		.lava_x(lava_x),
		.lava_y(lava_y),
		.game_over(game_over),
		.score(score),
		.red(VGA_R),
		.green(VGA_G),
		.blue(VGA_B)
		);
		
	VGAFrequency vga_clk(
		.clk(CLOCK_50),
		.VGAclk(vgaclk)
		);
	
	SevenSegScoreDisplay seven_seg_score_display(
		.clk(vgaclk),
		.score(score),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2)
		);
	
	SignalFrequency signalfrequency(
		.clk(CLOCK_50),
		.clk10(clk10)
		);
		
	plane draw_plane(  //modified
		.clk10(clk10),
		.resetn(KEY[1]),
		.game_over(game_over),
		.up(~KEY[0]),
		.down(KEY[0]),
		.plane_y(plane_y)
		);
	
	mountain draw_mountains(   //modified
		.clk10(clk10),
		.resetn(KEY[1]),
		.game_over(game_over),
	    .rand_offset(4'b0),
	    .mountain1_x(mountain1_x),
		.mountain1_y(mountain1_y),
		.mountain2_x(mountain2_x),
		.mountain2_y(mountain2_y),
		.score(score)
		);

	lava draw_lava( //modified
	.clk(clk10), 
	.resetn(resetn), 
	.game_over(game_over), 
	.score(score),
	.lava_x(lava_x),
	.lava_y(lava_y));
	
	check_crash check_crash(
		.resetn(KEY[1]),
		.plane_pos(plane_y),
		.mountain1_x(mountain1_x),
		.mountain1_y(mountain1_y),
		.mountain2_x(mountain2_x),
		.mountain2_y(mountain2_y),
		.lava_x(lava_x),
		.lava_y(lava_y),
		.game_over(game_over)
		);
	
endmodule