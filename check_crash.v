module check_crash(
    input resetn,
    input [9:0] plane_pos,
    input [9:0] mountain1_x_pos,
    input [9:0] mountain1_y_pos,
    input [9:0] mountain2_x_pos,
    input [9:0] mountain2_y_pos,
    input [9:0] lava_x_pos,
    input [9:0] lava_y_pos,
    output game_over
    );
	
	wire crash;
	wire [9:0]plane_x;
	
	assign plane_x = 9'd30;
	
	assign crash = (((plane_pos+9'd4 >= mountain1_y_pos+9'd50) or (plane_pos-9'd4 >=mountain1_y_pos-9'd50)) and (plane_x+9'd4 >= mountain1_x_pos))
				or (((plane_pos+9'd4 >= mountain2_y_pos+9'd50) or (plane_pos-9'd4 >=mountain2_y_pos-9'd50))and (plane_x+9'd4 >= mountain2_x_pos))
				or (((plane_pos+9'd4 >= lava_y_pos+9'd4) or (plane_pos-9'd4 >=lava_y_pos-9'd4)) 
				and( plane_x+9'd4 >= lava_x_pos-9'd4));
				
	assign game_over = (!resetn or crash)? 1'b1 : 1'b0;
endmodule