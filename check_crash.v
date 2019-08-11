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
	
	//game_over is 1 when plane crashes with something else or reset is pressed.
	//Otherwise, game_over is 0 and the game continues.
	
	wire crash;
	wire [9:0]plane_x;
	
	assign plane_x = 9'd120;
	
	assign crash = (((plane_y+9'd16 >= mountain1_y) && (plane_x+9'd16 >= mountain1_x))
				|| ((plane_y+9'd16 >= mountain2_y) && (plane_x+9'd16 >= mountain2_x))
				|| ((plane_y == lava_y) && (plane_x+9'd16 >= lava_x)));
				
	assign game_over = (~resetn || crash)? 1'b1 : 1'b0;
endmodule