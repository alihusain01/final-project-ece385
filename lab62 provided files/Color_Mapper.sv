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


module  color_mapper ( input pixel_clk, Reset,
								input        [9:0] ShipX, ShipY, DrawX, DrawY, Ship_sizeX, Ship_sizeY, 
							 input [9:0] AlienX[15], AlienY[15], Alien_sizeX[15],Alien_sizeY[15],
							 input [9:0] MissileX, MissileY, Missile_sizeX, Missile_sizeY,
                       output logic [7:0]  Red, Green, Blue,
								output logic Collision);
    
logic ship_on,alien_on, missile_on, alien_on_color[3];
	 
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
	 
//FOR MISSILE
    int DistXM, DistYM, SizeXM, SizeYM;
	 assign DistXM = DrawX - MissileX;
    assign DistYM = DrawY - MissileY;
    assign SizeXM = Missile_sizeX;
	 assign SizeYM = Missile_sizeY;

//FOR COLLISION
	logic [4:0] alien_on_number;
	logic alienLife[15] = '{1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};

//	always_ff @ (posedge Reset) begin
//	alienLife[15]= '{1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
//	end
	 
       
	  
    always_comb
    begin:Ship_on_proc
        //if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) //ball
		  if(DistX>=0 && DistX<=SizeX &&DistY>=0&&DistY<=SizeY)  //square
            ship_on = 1'b1; 
        else 
            ship_on = 1'b0;
     end 
	  

always_comb begin

	if((DistXA[0] >= 0 && DistXA[0] <= SizeXA && DistYA[0] >= 0 && DistYA[0] <= SizeYA) && alienLife[0]==1'b1) begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1; 
	alien_on_number = 0;
	end
	
	else if((DistXA[1] >= 0 && DistXA[1] <= SizeXA && DistYA[1] >= 0 && DistYA[1] <= SizeYA) && alienLife[1]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 1;end
	
	else if((DistXA[2] >= 0 && DistXA[2] <= SizeXA && DistYA[2] >= 0 && DistYA[2] <= SizeYA) && alienLife[2]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 2;	end
	
	else if((DistXA[3] >= 0 && DistXA[3] <= SizeXA && DistYA[3] >= 0 && DistYA[3] <= SizeYA) && alienLife[3]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1;
	alien_on_number = 3;end
	
	else if((DistXA[4] >= 0 && DistXA[4] <= SizeXA && DistYA[4] >= 0 && DistYA[4] <= SizeYA) && alienLife[4]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[0] = 1'b1; 
	alien_on_number = 4; end
	
	else if((DistXA[5] >= 0 && DistXA[5] <= SizeXA && DistYA[5] >= 0 && DistYA[5] <= SizeYA) && alienLife[5]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1;
	alien_on_number = 5;	end
	
	else if((DistXA[6] >= 0 && DistXA[6] <= SizeXA && DistYA[6] >= 0 && DistYA[6] <= SizeYA) && alienLife[6]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1;
	alien_on_number = 6;	end
	
	else if((DistXA[7] >= 0 && DistXA[7] <= SizeXA && DistYA[7] >= 0 && DistYA[7] <= SizeYA) && alienLife[7]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 7;end
	
	else if((DistXA[8] >= 0 && DistXA[8] <= SizeXA && DistYA[8] >= 0 && DistYA[8] <= SizeYA) && alienLife[8]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 8;	end
	
	else if((DistXA[9] >= 0 && DistXA[9] <= SizeXA && DistYA[9] >= 0 && DistYA[9] <= SizeYA) && alienLife[9]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[1] = 1'b1; 
	alien_on_number = 9;	end
	
	else if((DistXA[10] >= 0 && DistXA[10] <= SizeXA && DistYA[10] >= 0 && DistYA[10] <= SizeYA) && alienLife[10]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 10;	end
	
	else if((DistXA[11] >= 0 && DistXA[11] <= SizeXA && DistYA[11] >= 0 && DistYA[11] <= SizeYA) && alienLife[11]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 11;	end
	
	else if((DistXA[12] >= 0 && DistXA[12] <= SizeXA && DistYA[12] >= 0 && DistYA[12] <= SizeYA) && alienLife[12]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 12;	end
	
	else if((DistXA[13] >= 0 && DistXA[13] <= SizeXA && DistYA[13] >= 0 && DistYA[13] <= SizeYA) && alienLife[13]==1'b1)begin
	alien_on = 1'b1;
	alien_on_color[2] = 1'b1; 
	alien_on_number = 13;	end
	
	else if((DistXA[14] >= 0 && DistXA[14] <= SizeXA && DistYA[14] >= 0 && DistYA[14] <= SizeYA) && alienLife[14]==1'b1)begin
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
begin: missile_on_proc
		  if(DistXM>=0 && DistXM <= SizeXM && DistYM>=0 && DistYM <= SizeYM)  //square
            missile_on = 1'b1; 
        else 
            missile_on = 1'b0;
end

always_ff @ (posedge pixel_clk)
begin: Collision_Logic
	if((alien_on == 1'b1) && (missile_on == 1'b1))
	begin
	Collision <= 1'b1;
	alienLife[alien_on_number] <= 1'b0;
	end
	if(DrawX > 790 && DrawY > 520)
	Collision <= 1'b0;
end
	
always_ff @ (posedge pixel_clk)
 begin:RGB_Display
	  if ((ship_on == 1'b1)) 
	  begin 
			Red = 8'hff;
			Green = 8'h55;
			Blue = 8'h00;
	  end  
	  else if ((alien_on == 1'b1)) 
	  begin 
			if(alien_on_color[0] == 1'b1) begin // green
			Red = 8'h00;
			Green = 8'h55;
			Blue = 8'h00; end
			else if(alien_on_color[1] == 1'b1) begin //pink maybe
			Red = 8'h02;
			Green = 8'h23;
			Blue = 8'h20; end
			else begin //red 
			Red = 8'hFF;
			Green = 8'h00;
			Blue = 8'h00; end
	  end
	  else if (missile_on == 1'b1)
	  begin
			Red = 8'hFF;
			Green = 8'hFF;
			Blue = 8'h00;
	  end
	  else 
	  begin 
			Red = 8'h00; 
			Green = 8'h00;
			Blue = 8'h7f - DrawX[9:3];
	  end      
 end 
    
endmodule
