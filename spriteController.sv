module spriteController(input Clk, input [9:0] drawX, drawY, ShipX, ShipY, 
								input [9:0] AlienX [15], AlienY[15], 
								output [9:0] Ship_Address, NWRom_Address, PurdueRom_Address, WiscoRom_Address, 
								output [18:0] backgroundRom_Address
);

// SHIP/UIUC Controller 
int DistX, DistY, SizeX, SizeY;
	always_comb begin
	 DistX = drawX - ShipX;
    DistY = drawY - ShipY;
    SizeX = 25;
	 SizeY = 25;
	 end
	 
always_comb begin
backgroundRom_Address = (drawY * 640) + drawX;
end	 

always_comb begin
if(DistX >= 0 && DistX < SizeX && DistY >= 0 && DistY < SizeY)
Ship_Address = (DistY * SizeX) + DistX;
else 
Ship_Address = 0; 
end

//Alien Controller
 int DistXA[15], DistYA[15];
 int SizeXA, SizeYA;
 
 assign SizeXA = 25;
 assign SizeYA = 20;
 
 always_comb
 begin
	//NW
	DistXA[0] = drawX - AlienX[0];
	DistYA[0] = drawY - AlienY[0];
	DistXA[1] = drawX - AlienX[1];
	DistYA[1] = drawY - AlienY[1];
	DistXA[2] = drawX - AlienX[2];
	DistYA[2] = drawY - AlienY[2];
	DistXA[3] = drawX - AlienX[3];
	DistYA[3] = drawY - AlienY[3];
	DistXA[4] = drawX - AlienX[4];
	DistYA[4] = drawY - AlienY[4];
	//Purdue
	DistXA[5] = drawX - AlienX[5];
	DistYA[5] = drawY - AlienY[5];
	DistXA[6] = drawX - AlienX[6];
	DistYA[6] = drawY - AlienY[6];
	DistXA[7] = drawX - AlienX[7];
	DistYA[7] = drawY - AlienY[7];
	DistXA[8] = drawX - AlienX[8];
	DistYA[8] = drawY - AlienY[8];
	DistXA[9] = drawX - AlienX[9];
	DistYA[9] = drawY - AlienY[9];
	//Wisconsin
	DistXA[10] = drawX - AlienX[10];
	DistYA[10] = drawY - AlienY[10];
	DistXA[11] = drawX - AlienX[11];
	DistYA[11] = drawY - AlienY[11];
	DistXA[12] = drawX - AlienX[12];
	DistYA[12] = drawY - AlienY[12];
	DistXA[13] = drawX - AlienX[13];
	DistYA[13] = drawY - AlienY[13];
	DistXA[14] = drawX - AlienX[14];
	DistYA[14] = drawY - AlienY[14];
	
	end
	
always_comb begin

	if((DistXA[0] >= 0 && DistXA[0] < SizeXA && DistYA[0] >= 0 && DistYA[0] < SizeYA)) begin
	NWRom_Address = (DistYA[0] * SizeXA) + DistXA[0];
	PurdueRom_Address = 0;	
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[1] >= 0 && DistXA[1] < SizeXA && DistYA[1] >= 0 && DistYA[1] < SizeYA))begin
	NWRom_Address = (DistYA[1] * SizeXA) + DistXA[1];
	PurdueRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[2] >= 0 && DistXA[2] < SizeXA && DistYA[2] >= 0 && DistYA[2] < SizeYA))begin
	NWRom_Address = (DistYA[2] * SizeXA) + DistXA[2];
	PurdueRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[3] >= 0 && DistXA[3] < SizeXA && DistYA[3] >= 0 && DistYA[3] < SizeYA))begin
	NWRom_Address = (DistYA[3] * SizeXA) + DistXA[3];
	PurdueRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[4] >= 0 && DistXA[4] < SizeXA && DistYA[4] >= 0 && DistYA[4] < SizeYA))begin
	NWRom_Address = (DistYA[4] * SizeXA) + DistXA[4];
	PurdueRom_Address = 0;
	WiscoRom_Address = 0;
	end

	else if((DistXA[5] >= 0 && DistXA[5] < SizeXA && DistYA[5] >= 0 && DistYA[5] < SizeYA)) begin
	PurdueRom_Address = (DistYA[5] * SizeXA) + DistXA[5];	
	NWRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[6] >= 0 && DistXA[6] < SizeXA && DistYA[6] >= 0 && DistYA[6] < SizeYA))begin
	PurdueRom_Address = (DistYA[6] * SizeXA) + DistXA[6];
	NWRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[7] >= 0 && DistXA[7] < SizeXA && DistYA[7] >= 0 && DistYA[7] < SizeYA))begin
	PurdueRom_Address = (DistYA[7] * SizeXA) + DistXA[7];
	NWRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[8] >= 0 && DistXA[8] < SizeXA && DistYA[8] >= 0 && DistYA[8] < SizeYA))begin
	PurdueRom_Address = (DistYA[8] * SizeXA) + DistXA[8];
	NWRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if((DistXA[9] >= 0 && DistXA[9] < SizeXA && DistYA[9] >= 0 && DistYA[9] < SizeYA))begin
	PurdueRom_Address = (DistYA[9] * SizeXA) + DistXA[9];
	NWRom_Address = 0;
	WiscoRom_Address = 0;
	end
	
	else if(((DistXA[10] >= 0) && (DistXA[10] < SizeXA) && (DistYA[10] >= 0) && (DistYA[10] < SizeYA)))begin
	WiscoRom_Address = (DistYA[10] * SizeXA) + DistXA[10];
	PurdueRom_Address = 0;
	NWRom_Address = 0; end
	
	else if(((DistXA[11] >= 0) && (DistXA[11] < SizeXA) && (DistYA[11] >= 0) && (DistYA[11] < SizeYA)))begin
	WiscoRom_Address = (DistYA[11] * SizeXA) + DistXA[11];
	PurdueRom_Address = 0;
	NWRom_Address = 0; end
	
	else if(((DistXA[12] >= 0) && (DistXA[12] < SizeXA) && (DistYA[12] >= 0) && (DistYA[12] < SizeYA)))begin
	WiscoRom_Address = (DistYA[12] * SizeXA) + DistXA[12];
	PurdueRom_Address = 0;
	NWRom_Address = 0; end
	
	else if(((DistXA[13] >= 0) && (DistXA[13] < SizeXA) && (DistYA[13] >= 0) && (DistYA[13] < SizeYA)))begin
	WiscoRom_Address = (DistYA[13] * SizeXA) + DistXA[13];
	PurdueRom_Address = 0;
	NWRom_Address = 0; end
	
	else if(((DistXA[14] >= 0) && (DistXA[14] < SizeXA) && (DistYA[14] >= 0) && (DistYA[14] < SizeYA)))begin
	WiscoRom_Address = (DistYA[14] * SizeXA) + DistXA[14];
	PurdueRom_Address = 0;
	NWRom_Address = 0; end
	
	else begin
	NWRom_Address = 0;
	PurdueRom_Address = 0;
	WiscoRom_Address = 0;
	end
	

end


endmodule
