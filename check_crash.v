module check_crash(
    input resetn,
    input clk,
    input [9:0] plane_y,
    input [9:0] mountain1_x,
    input [9:0] mountain1_y,
    input [9:0] mountain2_x,
    input [9:0] mountain2_y,
    input [9:0] lava_x,
    input [9:0] lava_y,
	 
	 output reg [2:0]life,
	 
    output game_over
    );
	//game_over is 1 when plane crashes with something else || reset is pressed.
	//Otherwise, game_over is 0 && the game continues.
	
	wire crash;
	wire [9:0]plane_x;
	
	assign plane_x = 9'd100;
	
	assign crash = ((plane_y+9'd16 >= mountain1_y) && (plane_x+9'd16 >= mountain1_x) && (plane_x<= mountain1_x+50))
				|| (((plane_y+9'd16 >= mountain2_y) && (plane_x+9'd16 >= mountain2_x) && (plane_x<= mountain2_x+50)))
				|| ((( plane_x<= lava_x+8'd16)&& ( plane_x>= lava_x))&& ((plane_y<=lava_y+9'd16) && (plane_y>=lava_y)));
				
	always @(posedge clk, negedge resetn) 
	begin
		if(~resetn) life<=3'd3;
		else if (crash && life >0) life <= life-1;
	end
	
	assign game_over = (~resetn || life<= 3'd0)? 1'b1 : 1'b0;
	
endmodule
