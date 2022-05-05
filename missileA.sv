//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  missileA ( input Reset, frame_clk, CollisionA, 
					input [9:0] AlienX, AlienY, Alien_sizeX, AlienXMotion,
					input logic [9:0] AlienX_Offset,
               output logic [9:0]  MissileX, MissileY);
    
    logic [9:0] Missile_X_Pos, Missile_X_Motion, Missile_Y_Pos, Missile_Y_Motion, Missile_SizeX, Missile_SizeY;
	 
    logic [9:0] Missile_X_On_Alien;  // Center position on the X axis
    logic [9:0] Missile_Y_On_Alien;  // Center position on the Y axis
    logic [9:0] Missile_X_Min;       // Leftmost point on the X axis
    logic [9:0] Missile_X_Max;     // Rightmost point on the X axis
    parameter [9:0] Missile_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Missile_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Missile_X_Step=3;      // Step size on the X axis
    parameter [9:0] Missile_Y_Step=4;      // Step size on the Y axis

    assign Missile_SizeX = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign Missile_SizeY = 6;
	 
	 always_comb begin
	 Missile_X_On_Alien = AlienX + (Alien_sizeX/2);
	 Missile_Y_On_Alien = AlienY + 10;
	 Missile_X_Min = AlienX_Offset + (Alien_sizeX/2); 
	 Missile_X_Max = 639 -160 + AlienX_Offset+ Missile_SizeX-(Alien_sizeX/2);
	 end
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Missile
	 if (Reset)  // Asynchronous Reset
        begin 
            Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
				Missile_X_Motion <= 10'd1; //Missile_X_Step;
				Missile_Y_Pos = Missile_Y_On_Alien;
				Missile_X_Pos = Missile_X_On_Alien;
        end
		  
        else 
        begin 
				 if ( (Missile_Y_Pos + Missile_SizeY) >= Missile_Y_Max || CollisionA == 1'b1 )  // Missile is at the bottom edge, BOUNCE!
					  begin
							Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
 						   Missile_X_Motion <= AlienXMotion; //Missile_X_Step;
							Missile_Y_Pos = Missile_Y_On_Alien;
							Missile_X_Pos = Missile_X_On_Alien;
					  end
					
				  else if ( (Missile_X_Pos + Missile_SizeX) >= Missile_X_Max )  // Missile is at the Right edge, BOUNCE!
					 //else if( (Missile_X_Pos + Missile_SizeX) >=300)
					  begin 
						Missile_Y_Pos += 25;
					  Missile_X_Pos -= 1;
					  Missile_X_Motion <= -1;
					  end
					  
				 else if ( (Missile_X_Pos - 25) <= Missile_X_Min )  // Missile is at the Left edge, BOUNCE!
					  begin 
						Missile_Y_Pos += 25;
					  Missile_X_Pos += 1;
					  Missile_X_Motion <= 1;
					  end
					 
					  
				 else begin
					  Missile_Y_Motion <= Missile_Y_Motion;  // Missile is somewhere in the middle, don't bounce, just keep moving
						Missile_X_Motion<= Missile_X_Motion;
						end
				 
				 Missile_Y_Pos = (Missile_Y_Pos + Missile_Y_Motion);  // Update Missile position
				 Missile_X_Pos = (Missile_X_Pos + Missile_X_Motion);			
		end  
    end
//        if (Reset)  // Asynchronous Reset
//        begin 
//      //      Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
//			//	Missile_X_Motion <= 10'd1; //Missile_X_Step;
//				Missile_Y_Pos = Missile_Y_On_Alien;
//				Missile_X_Pos = Missile_X_On_Alien;
//
//        end	
//        else if ( ((Missile_Y_Pos + Missile_SizeY) >= Missile_Y_Max) || (CollisionA==1'b1))  // Missile is at the bottom edge, BOUNCE!
//						begin
//							Missile_Y_Pos = Missile_Y_On_Alien;
//   						Missile_X_Pos = Missile_X_On_Alien;
//						//	Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
//					//		Missile_X_Motion <= AlienXMotion; //Missile_X_Step;
//							
//					   end		
////        else if(Missile_X_Pos == 300)
////					begin
////					Missile_Y_Motion <= 4;
////					Missile_X_Motion <= 0;
////					end						
//				 else begin
//					//  Missile_Y_Motion <= Missile_Y_Motion;
//					//  Missile_X_Motion <= AlienXMotion;
//					  Missile_Y_Pos <= Missile_Y_On_Alien;
//					  Missile_X_Pos <= Missile_X_On_Alien;
//					  end
//				 
//			
//				 
////				 Missile_Y_Pos = (Missile_Y_Pos + Missile_Y_Motion);  // Update Missile position
////				 Missile_X_Pos = (Missile_X_Pos + Missile_X_Motion);
//			
//			
//	  /**************************************************************************************
//	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
//		 Hidden Question #2/2:
//          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
//          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
//          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
//          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
//      **************************************************************************************/
//      
//			  
//    end
       
    assign MissileX = Missile_X_Pos;
   
    assign MissileY = Missile_Y_Pos;

    

endmodule
