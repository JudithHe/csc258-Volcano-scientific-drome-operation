module check_crash(
    input resetn,
    input [9:0] plane_y,
    input [9:0] mountain1_x,
    input [9:0] mountain1_y,
    input [9:0] mountain2_x,
    input [9:0] mountain2_y,
    input [9:0] lava_x,
    input [9:0] lava_y,
    output game_over
    );
	//game_over is 1 when plane crashes with something else | reset is pressed.
	//Otherwise, game_over is 0 & the game continues.
	
	wire crash;
	wire [9:0]plane_x;
	
	assign plane_x = 9'd100;
	
	assign crash = (((plane_y+9'd8 >= mountain1_y) | (plane_y-9'd8 >=mountain1_y)) & (plane_x+9'd8 >= mountain1_x))
				| (((plane_y+9'd8 >= mountain2_y) | (plane_y-9'd8 >=mountain2_y))& (plane_x+9'd8 >= mountain2_x))
				| ((( plane_x<= lava_x+8'd16)& ( plane_x>= lava_x))& ((plane_y<=lava_y+9'd16) & (plane_y>=lava_y)));
				
	assign game_over = (~resetn | crash)? 1'b1 : 1'b0;
endmodule