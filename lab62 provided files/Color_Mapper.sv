//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input pixel_clk, Reset, blank,
								input        [9:0] ShipX, ShipY, DrawX, DrawY, Ship_sizeX, Ship_sizeY, 
							 input [9:0] AlienX[15], AlienY[15], Alien_sizeX[15],Alien_sizeY[15],
							 input [9:0] MissileX, MissileY, Missile_sizeX, Missile_sizeY,
							 MissileAX[15], MissileAY[15],
							 input [23:0] uiucColor, NWColor, PurdueColor, WiscoColor,
                       output logic [7:0]  Red, Green, Blue,
								output logic Collision, CollisionA[15]);
    
logic ship_on,alien_on, missile_on, alien_on_color[3], missileA_on;


	 
//FOR SHIP	  
    int DistX, DistY, SizeX,SizeY;
	 assign DistX = DrawX - ShipX;
    assign DistY = DrawY - ShipY;
    assign SizeX = Ship_sizeX;
	 assign SizeY = Ship_sizeY;
	 
//FOR ALIEN		 
	 int DistXA[15], DistYA[15];
	 int SizeXA, SizeYA;
	 
	 always_comb
	 begin
		 for(int i = 0; i < 15; i++)
		 begin
			 DistXA[i] = DrawX - AlienX[i];
			 DistYA[i] = DrawY - AlienY[i];
		 end
		end
	 
	 assign SizeXA = Alien_sizeX[0];
	 assign SizeYA = Alien_sizeY[0];
	 
//FOR MISSILE Ship
    int DistXM, DistYM, SizeXM, SizeYM;
	 assign DistXM = DrawX - MissileX;
    assign DistYM = DrawY - MissileY;
    assign SizeXM = Missile_sizeX;
	 assign SizeYM = Missile_sizeY;
	  
//FOR MISSILE Alien
	 int DistXMA[15], DistYMA[15];
	 int SizeXMA, SizeYMA;
	 
	 always_comb begin
	 for(int j = 0; j < 15; j++) begin
	 DistXMA[j] = DrawX - MissileAX[j];
    
	 DistYMA[j] = DrawY - MissileAY[j];
	 end	
	 end
	 
	 assign SizeXMA = Missile_sizeX;
	 assign SizeYMA = Missile_sizeY;
	 

//FOR COLLISION
	logic [4:0] alien_on_number;
	logic alienLife[15] = '{1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
       
	  
    always_comb
    begin:Ship_on_proc
        //if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) //ball
		  if( (DistX>=0) && (DistX<SizeX) && (DistY>=0) && (DistY<SizeY))  //square
            ship_on = 1'b1; 
        else 
            ship_on = 1'b0;
     end 
	  

always_comb begin

	if(((DistXA[0] >= 0) && (DistXA[0] < SizeXA) && (DistYA[0] >= 0) && (DistYA[0] < SizeYA)) && alienLife[0]==1'b1) begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1; 
	alien_on_number = 0;
	end
	
	else if(((DistXA[1] >= 0) && (DistXA[1] < SizeXA) && (DistYA[1] >= 0) && (DistYA[1] < SizeYA)) && alienLife[1]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 1;end
	
	else if(((DistXA[2] >= 0) && (DistXA[2] < SizeXA) && (DistYA[2] >= 0) && (DistYA[2] < SizeYA)) && alienLife[2]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 2;	end
	
	else if(((DistXA[3] >= 0) && (DistXA[3] < SizeXA) && (DistYA[3] >= 0) && (DistYA[3] < SizeYA)) && alienLife[3]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 3;end
	
	else if(((DistXA[4] >= 0) && (DistXA[4] < SizeXA) && (DistYA[4] >= 0) && (DistYA[4] < SizeYA)) && alienLife[4]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1; 
	alien_on_number = 4; end
	
	else if(((DistXA[5] >= 0) && (DistXA[5] < SizeXA) && (DistYA[5] >= 0) && (DistYA[5] < SizeYA)) && alienLife[5]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1;
	alien_on_number = 5;	end
	
	else if(((DistXA[6] >= 0) && (DistXA[6] < SizeXA) && (DistYA[6] >= 0) && (DistYA[6] < SizeYA)) && alienLife[6]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1;
	alien_on_number = 6;	end
	
	else if(((DistXA[7] >= 0) && (DistXA[7] < SizeXA) && (DistYA[7] >= 0) && (DistYA[7] < SizeYA)) && alienLife[7]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 7;end
	
	else if(((DistXA[8] >= 0) && (DistXA[8] < SizeXA) && (DistYA[8] >= 0) && (DistYA[8] < SizeYA)) && alienLife[8]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 8;	end
	
	else if(((DistXA[9] >= 0) && (DistXA[9] < SizeXA) && (DistYA[9] >= 0) && (DistYA[9] < SizeYA)) && alienLife[9]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 9;	end
	
	else if(((DistXA[10] >= 0) && (DistXA[10] < SizeXA) && (DistYA[10] >= 0) && (DistYA[10] < SizeYA)) && alienLife[10]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 10;	end
	
	else if(((DistXA[11] >= 0) && (DistXA[11] < SizeXA) && (DistYA[11] >= 0) && (DistYA[11] < SizeYA)) && alienLife[11]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 11;	end
	
	else if(((DistXA[12] >= 0) && (DistXA[12] < SizeXA) && (DistYA[12] >= 0) && (DistYA[12] < SizeYA)) && alienLife[12]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 12;	end
	
	else if(((DistXA[13] >= 0) && (DistXA[13] < SizeXA) && (DistYA[13] >= 0) && (DistYA[13] < SizeYA)) && alienLife[13]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 13;	end
	
	else if(((DistXA[14] >= 0) && (DistXA[14] < SizeXA) && (DistYA[14] >= 0) && (DistYA[14] < SizeYA)) && alienLife[14]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 14;	end
	
	else begin
	alien_on = 1'b0;
	alien_on_color[0] = 1'b0;
	alien_on_color[1] = 1'b0;
	alien_on_color[2] = 1'b0;
	alien_on_number = 15;
	end
	

end

always_comb 
begin: alien_missile_on_proc
		   if(DistXMA[0] >=0 && DistXM[0] <= SizeXM && DistYM[0] >=0 && DistYM[0] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
		   else if(DistXMA[1] >=0 && DistXM[1] <= SizeXM && DistYM[1] >=0 && DistYM[1] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[2] >=0 && DistXM[2] <= SizeXM && DistYM[2] >=0 && DistYM[2] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[3] >=0 && DistXM[3] <= SizeXM && DistYM[3] >=0 && DistYM[3] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[4] >=0 && DistXM[4] <= SizeXM && DistYM[4] >=0 && DistYM[4] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[5] >=0 && DistXM[5] <= SizeXM && DistYM[5] >=0 && DistYM[5] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[6] >=0 && DistXM[6] <= SizeXM && DistYM[6] >=0 && DistYM[6] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[7] >=0 && DistXM[7] <= SizeXM && DistYM[7] >=0 && DistYM[7] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[8] >=0 && DistXM[8] <= SizeXM && DistYM[8] >=0 && DistYM[8] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[9] >=0 && DistXM[9] <= SizeXM && DistYM[9] >=0 && DistYM[9] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[10] >=0 && DistXM[10] <= SizeXM && DistYM[10] >=0 && DistYM[10] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[11] >=0 && DistXM[11] <= SizeXM && DistYM[11] >=0 && DistYM[11] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[12] >=0 && DistXM[12] <= SizeXM && DistYM[12] >=0 && DistYM[12] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[13] >=0 && DistXM[13] <= SizeXM && DistYM[13] >=0 && DistYM[13] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else if(DistXMA[14] >=0 && DistXM[14] <= SizeXM && DistYM[14] >=0 && DistYM[14] <= SizeYM)begin 
            missileA_on = 1'b1; 
				end
			else begin
				missileA_on = 1'b0;
				end
end

always_comb 
begin: missile_on_proc
		  if(DistXM>=0 && DistXM <= SizeXM && DistYM>=0 && DistYM <= SizeYM)  //square
            missile_on = 1'b1; 
        else 
            missile_on = 1'b0;
end

always_ff @ (posedge pixel_clk or posedge Reset)
begin: AlienLife_Logic
	if(Reset)
	begin
		alienLife[0] = 1'b1;
		alienLife[1] = 1'b1;
		alienLife[2] = 1'b1;
		alienLife[3] = 1'b1;
		alienLife[4] = 1'b1;
		alienLife[5] = 1'b1;
		alienLife[6] = 1'b1;
		alienLife[7] = 1'b1;
		alienLife[8] = 1'b1;
		alienLife[9] = 1'b1;
		alienLife[10] = 1'b1;
		alienLife[11] = 1'b1;
		alienLife[12] = 1'b1;
		alienLife[13] = 1'b1;
		alienLife[14] = 1'b1;
	end	
	else if((alien_on == 1'b1) && (missile_on == 1'b1))
	begin
	alienLife[alien_on_number] <= 1'b0;
	end
end

//for Collision
always_ff @ (posedge pixel_clk)
begin: Collision_Logic 
if(DrawX > 790 && DrawY > 520)
	Collision <= 1'b0;
else if((alien_on == 1'b1) && (missile_on == 1'b1))
	Collision <= 1'b1;
end

//for Alien Missile Collision
always_ff @ (posedge pixel_clk)
begin: Collision_LogicA 
if(DrawX > 790 && DrawY > 520)
	CollisionA[0] <= 1'b0;
	else if((ship_on == 1'b1) && (missileA_on == 1'b1))
	CollisionA[0] <= 1'b1;
	else CollisionA[0]=1'b0;
//	else if(Missile)
//	CollisionA <= 1'b0;
end
	
always_ff @ (posedge pixel_clk)
 begin:RGB_Display
//		if(blank==1'b0) begin
//		Red = 8'h00;
//		Green = 8'h00;
//		Blue = 8'h00;
//		end else 
//		begin
	  if ((ship_on == 1'b1) && (uiucColor[23:20] != 4'hF)) 
	  begin 
//     		Red = 8'hff;
//			Green = 8'h55;
//			Blue = 8'h00;
		Red = uiucColor[23:16];
		Green = uiucColor[15:8];
		Blue = uiucColor[7:0];
	  end  
	  //else if ((alien_on == 1'b1))  
			else if((alien_on == 1'b1) && (alien_on_color[0] == 1'b1) && (NWColor[23:20] != 4'hF)) begin // green
//			Red = 8'h00;
//			Green = 8'h55;
//			Blue = 8'h00; end
			Red = NWColor[23:16];
			Green = NWColor[15:8];
			Blue = NWColor[7:0]; end
			
			else if((alien_on == 1'b1) && (alien_on_color[1] == 1'b1) && (PurdueColor[23:20] != 4'hF)) begin //pink maybe
//			Red = 8'h02;
//			Green = 8'h23;
//			Blue = 8'h20; end
			Red = PurdueColor[23:16];
			Green = PurdueColor[15:8];
			Blue = PurdueColor[7:0]; end
			else if ((alien_on == 1'b1) && (alien_on_color[2] == 1'b1) && (WiscoColor[23:20] != 4'hF)) begin
			//red
			Red = WiscoColor[23:16];
			Green = WiscoColor[15:8];
			Blue = WiscoColor[7:0]; 
			end
	  else if (missile_on == 1'b1)
	  begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'h00;
	  end
//	   else if (missileA_on == 1'b1)
//	  begin
//			Red = 8'hFF;
//			Green = 8'hFF;
//			Blue = 8'h00;
//	  end
	  else 
	  begin 
			Red = 8'h00; 
			Green = 8'h00;
			Blue = 8'h7f - DrawX[9:3];
//			Red = backgroundColor[23:16]; 
//			Green = backgroundColor[15:8];
//			Blue = backgroundColor[7:0];
	  end      
 end
 
    
endmodule
