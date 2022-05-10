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
								input [7:0] keycode,
							 input [9:0] AlienX[15], AlienY[15], Alien_sizeX[15],Alien_sizeY[15],
							 input [9:0] MissileX, MissileY, Missile_sizeX, Missile_sizeY,
							 MissileAX[15], MissileAY[15],
							 input [23:0] uiucColor, NWColor, PurdueColor, WiscoColor,
                       output logic [7:0]  Red, Green, Blue,
								output logic Collision, CollisionA[15]);
    
logic ship_on,alien_on, missile_on, alien_on_color[3], missileA_on1, missileA_on2;
logic start=1'b0;
logic win=1'b0;
logic lose=1'b0;

	 
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
	logic [4:0] missileA_on_number1;
	logic [4:0] missileA_on_number2;	 
	

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
begin: alien_missile_on_proc1
				missileA_on1 = 1'b0;
				missileA_on_number1=15;
				
		   if(DistXMA[0] >=0 && DistXMA[0] < SizeXMA && DistYMA[0] >=0 && DistYMA[0] < SizeYMA && alienLife[0]==1'b1)
			begin 	 
            missileA_on1 = 1'b1; 
				missileA_on_number1=0;
				end
		    if(DistXMA[1] >=0 && DistXMA[1] < SizeXMA && DistYMA[1] >=0 && DistYMA[1] < SizeYMA && alienLife[1]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
				missileA_on_number1=1;
				end
			 if(DistXMA[2] >=0 && DistXMA[2] < SizeXMA && DistYMA[2] >=0 && DistYMA[2] < SizeYMA && alienLife[2]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
				missileA_on_number1=2;
				end
			 if(DistXMA[3] >=0 && DistXMA[3] < SizeXMA && DistYMA[3] >=0 && DistYMA[3] < SizeYMA && alienLife[3]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
				missileA_on_number1=3;
				end
			 if(DistXMA[4] >=0 && DistXMA[4] < SizeXMA && DistYMA[4] >=0 && DistYMA[4] < SizeYMA && alienLife[4]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
			missileA_on_number1=4;
				end
			 if(DistXMA[5] >=0 && DistXMA[5] < SizeXMA && DistYMA[5] >=0 && DistYMA[5] < SizeYMA && alienLife[5]==1'b1)
			begin 
            missileA_on1 = 1'b1;
				missileA_on_number1=5;
				end
			 if(DistXMA[6] >=0 && DistXMA[6] < SizeXMA && DistYMA[6] >=0 && DistYMA[6] < SizeYMA && alienLife[6]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
				missileA_on_number1=6;
				end
			 if(DistXMA[7] >=0 && DistXMA[7] < SizeXMA && DistYMA[7] >=0 && DistYMA[7] < SizeYMA && alienLife[7]==1'b1)
			begin 
            missileA_on1 = 1'b1; 
				missileA_on_number1=7;
				end
	end
	
always_comb 
begin: alien_missile_on_proc2
				missileA_on2 = 1'b0;
				missileA_on_number2=15;
			 if(DistXMA[8] >=0 && DistXMA[8] < SizeXMA && DistYMA[8] >=0 && DistYMA[8] < SizeYMA && alienLife[8]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=8;
				end
			 if(DistXMA[9] >=0 && DistXMA[9] < SizeXMA && DistYMA[9] >=0 && DistYMA[9] < SizeYMA && alienLife[9]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=9;
				end
			 if(DistXMA[10] >=0 && DistXMA[10] < SizeXMA && DistYMA[10] >=0 && DistYMA[10] < SizeYMA && alienLife[10]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=10;
				end
			 if(DistXMA[11] >=0 && DistXMA[11] < SizeXMA && DistYMA[11] >=0 && DistYMA[11] < SizeYMA && alienLife[11]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=11;
				end
			 if(DistXMA[12] >=0 && DistXMA[12] < SizeXMA && DistYMA[12] >=0 && DistYMA[12] < SizeYMA && alienLife[12]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=12;
				end
			 if(DistXMA[13] >=0 && DistXMA[13] < SizeXMA && DistYMA[13] >=0 && DistYMA[13] < SizeYMA && alienLife[13]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=13;
				end
			 if(DistXMA[14] >=0 && DistXMA[14] < SizeXMA && DistYMA[14] >=0 && DistYMA[14] < SizeYMA && alienLife[14]==1'b1)
			begin 
            missileA_on2 = 1'b1; 
				missileA_on_number2=14;
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
	begin
	CollisionA[0] <= 1'b0;
	CollisionA[1] <= 1'b0;
	CollisionA[2] <= 1'b0;
	CollisionA[3] <= 1'b0;
	CollisionA[4] <= 1'b0;
	CollisionA[5] <= 1'b0;
	CollisionA[6] <= 1'b0;
	CollisionA[7] <= 1'b0;
	CollisionA[8] <= 1'b0;
	CollisionA[9] <= 1'b0;
	CollisionA[10] <= 1'b0;
	CollisionA[11] <= 1'b0;
	CollisionA[12] <= 1'b0;
	CollisionA[13] <= 1'b0;
	CollisionA[14] <= 1'b0;
	end
	else if((ship_on == 1'b1) && ((missileA_on1 == 1'b1) || (missileA_on2 == 1'b1)))
	begin
		if(missileA_on1==1'b1) begin
		CollisionA[missileA_on_number1] <= 1'b1;
		end
		else begin
		CollisionA[missileA_on_number2] <= 1'b1;
		end
	end
	//else CollisionA[missileA_on_number]=1'b0;
end
	
	
//for start screen
always_ff @ (posedge Reset or posedge pixel_clk)
begin
	if(Reset)
	start<=1'b0;
	else begin
	case (keycode)
	8'h2C: begin
		start<=1'b1;
		end
	default: begin
		start<=start;
	end
	endcase
end
end	

//for end screen
always_comb
begin
	if(alienLife[0]==1'b0 && alienLife[1]==1'b0 && alienLife[2]==1'b0 &&alienLife[3]==1'b0 &&alienLife[4]==1'b0 &&alienLife[5]==1'b0 &&alienLife[6]==1'b0 &&alienLife[7]==1'b0 &&
   alienLife[8]==1'b0 &&alienLife[9]==1'b0 &&alienLife[10]==1'b0 &&alienLife[11]==1'b0 &&alienLife[12]==1'b0 &&alienLife[13]==1'b0 &&alienLife[14]==1'b0)	
		begin
		win=1'b1;
		//lose=1'b0;
		end
		
//	else if(CollisionA[0]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[1]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[2]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[3]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[4]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[5]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[6]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[7]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[8]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[9]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[10]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[11]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[12]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[13]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
//	else if(CollisionA[14]==1'b1)
//	begin
//		lose=1'b1;
//		win = 1'b0;
//		end
	else begin
	win = 1'b0;
	//lose = 1'b0;
	end	
end

logic onTitle;

always_comb begin
if (DrawX >= 100 && DrawX < 498 && DrawY >= 200 && DrawY < 291) onTitle = 1'b1;
else onTitle = 1'b0;
end	

always_ff @ (posedge pixel_clk)
 begin:RGB_Display
		if(blank==1'b0) begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'h00;
		end  

		else if((start==1'b0)) //&& (onTitle == 1'b1) && (TitleColor[23:20] != 4'hF))
		begin
//			Red = TitleColor[23:16];
//			Green = TitleColor[15:8];
//			Blue = TitleColor[7:0];
			Red = 8'h00;
			Green = 8'h00;
			Blue = 8'h4f;
		end
		
		else if(win==1'b1)
		begin
			Red = 8'h00;
			Green = 8'hff;
			Blue = 8'h00;
		end
		
		else if(lose==1'b1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end
		
			else if ((ship_on == 1'b1) && (uiucColor[23:20] != 4'hF)) begin 
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
			Blue = NWColor[7:0]; 
			end
			else if((alien_on == 1'b1) && (alien_on_color[1] == 1'b1) && (PurdueColor[23:20] != 4'hF)) begin //pink maybe
//			Red = 8'h02;
//			Green = 8'h23;
//			Blue = 8'h20; end
			Red = PurdueColor[23:16];
			Green = PurdueColor[15:8];
			Blue = PurdueColor[7:0]; 
			end
			else if ((alien_on == 1'b1) && (alien_on_color[2] == 1'b1) && (WiscoColor[23:20] != 4'hF)) begin
			//red
			Red = WiscoColor[23:16];
			Green = WiscoColor[15:8];
			Blue = WiscoColor[7:0]; 
			end
			else if (missile_on == 1'b1)begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'h00;
			end
			else if ((missileA_on1 == 1'b1||missileA_on2 == 1'b1)) begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'h00;
			end
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
