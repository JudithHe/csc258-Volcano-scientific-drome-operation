module VGA_Controller(
	input clk,
	input resetn,
	output reg vga_HS,
	output reg vga_VS,
	output reg [9:0] X,
	output reg [9:0] Y,
	output reg display
);

	// parameter is the same word as const
   // horizontal values 
	parameter H_color_scan=640;
	parameter H_front_porch=16;
	parameter H_synch_pulse=96;
	parameter H_back_porch=48;
	parameter H_scan_width=800;
	
	// verticle lines 
	parameter V_color_scan=480;
	parameter V_front_porch=10;
	parameter V_synch_pulse=2;
	parameter V_back_porch=33;
		parameter V_scan_width=525;
	
	// registers for holding the vga coordinates of the screen we're currently wring to
	reg [9:0] V_pos,H_pos;
	

	// generate the horizontal and verticle synch signals
	always @(posedge clk, negedge resetn) begin
	 if (!resetn) begin
		H_pos <= 0;
		V_pos <= 0;
		end
	 else begin
		if(H_pos < H_scan_width) begin
			H_pos <= H_pos + 1;
		end else begin // we've reached the end of a verticle scan line
			H_pos <= 0;
			
			if(V_pos < V_scan_width) begin
				V_pos <= V_pos + 1;
			end else begin
				V_pos <= 0;
			end
		end
		
		// generate the vs and hs signals
	
		// horizontal pulse 
		if(H_pos > H_front_porch && H_pos < (H_front_porch+H_synch_pulse)) begin
			vga_HS <= 1'b0;
		end else begin
			vga_HS <= 1'b1;
		end
		
		// verticle pulse 
		if(V_pos > V_front_porch && V_pos < (V_front_porch+V_synch_pulse)) begin
			vga_VS <= 1'b0;
		end else begin
			vga_VS <= 1'b1;
		end
		
		// set display to true when we're in the color scan region of the horizontal pulse 
		if((H_pos > (H_front_porch + H_synch_pulse + H_back_porch))) begin
				display <= 1'b1;
				X <= H_pos - (H_front_porch + H_synch_pulse + H_back_porch -1)+100;
				Y <= V_pos - (V_front_porch + V_synch_pulse + V_back_porch -1);
		end else begin
				display <= 1'b0;
				X <= 0;
				Y <= 0;
		end
		end
		
	end
	
endmodule