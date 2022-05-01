module spriteController(input Clk, input [9:0] drawX, drawY, ShipX, ShipY, 
								output [9:0] Ship_Address
);

int DistX, DistY, SizeX, SizeY;
	always_comb begin
	 DistX = drawX - ShipX;
    DistY = drawY - ShipY;
    SizeX = 25;
	 SizeY = 25;
	 end

always_comb begin
if(DistX >= 0 && DistX < SizeX && DistY >= 0 && DistY < SizeY)
Ship_Address = (DistY * SizeX) + DistX;
else 
Ship_Address = 0; 
end

endmodule
