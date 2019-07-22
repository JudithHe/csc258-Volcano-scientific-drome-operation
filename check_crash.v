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
	
	wire crash;
	wire [9:0]plane_x;
	
	assign plane_x = 9'd30;
	
	assign crash = (((plane_y+9'd4 >= mountain1_y+9'd50) or (plane_y-9'd4 >=mountain1_y-9'd50)) and (plane_x+9'd4 >= mountain1_x))
				or (((plane_y+9'd4 >= mountain2_y+9'd50) or (plane_y-9'd4 >=mountain2_y-9'd50))and (plane_x+9'd4 >= mountain2_x))
				or (((plane_y+9'd4 >= lava_y+9'd4) or (plane_y-9'd4 >=lava_y-9'd4)) 
				and( plane_x+9'd4 >= lava_x-9'd4));
				
	assign game_over = (!resetn or crash)? 1'b1 : 1'b0;
endmodule