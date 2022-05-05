module uiucROM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

logic [3:0] mem [0:624];

initial 
begin
	$readmemh("spriteBytes/uiuc.txt", mem);
end

always_ff @ (posedge Clk) begin
		if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

module uiucPalette
(
		input [23:0] data_In,
		input [3:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

logic [23:0] mem [0:7];

initial 
begin
	$readmemh("spriteBytes/uiucPalette.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

/////////////////////////////////////////////////////////////////////////////////
//PURDUE

module NWROM
(
		input [3:0] data_In,
		input [9:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

logic [3:0] mem [0:499];

initial 
begin
	$readmemh("spriteBytes/NW.txt", mem);
end

always_ff @ (posedge Clk) begin
		if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

module NWPalette
(
		input [23:0] data_In,
		input [3:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

logic [23:0] mem [0:5];

initial 
begin
	$readmemh("spriteBytes/NWPalette.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

////////////////////////////////////////////////////////////////////
//Purdue
module PurdueROM
(
		input [3:0] data_In,
		input [9:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

logic [3:0] mem [0:499];

initial 
begin
	$readmemh("spriteBytes/Purdue.txt", mem);
end

always_ff @ (posedge Clk) begin
		if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

module PurduePalette
(
		input [23:0] data_In,
		input [3:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

logic [23:0] mem [0:5];

initial 
begin
	$readmemh("spriteBytes/PurduePalette.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

/////////////////////////////////////////////////////////////////////////////////
module WiscoROM
(
		input [3:0] data_In,
		input [9:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

logic [3:0] mem [0:499];

initial 
begin
	$readmemh("spriteBytes/wisconsin.txt", mem);
end

always_ff @ (posedge Clk) begin
		if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule

module WiscoPalette
(
		input [23:0] data_In,
		input [3:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

logic [23:0] mem [0:7];

initial 
begin
	$readmemh("spriteBytes/wisconsinPalette.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out <= mem[read_address];
end

endmodule
////////////////////////////////////////////////////////////////
//background
//module backgroundROM
//(
//		input [3:0] data_In,
//		input [18:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [3:0] data_Out
//);
//
//logic [3:0] mem [0:307199];
//
//initial 
//begin
//	$readmemh("spriteBytes/background.txt", mem);
//end
//
//always_ff @ (posedge Clk) begin
//		if (we)
//		mem[write_address] <= data_In;
//	data_Out <= mem[read_address];
//end
//
//endmodule
//
//module backgroundPalette
//(
//		input [23:0] data_In,
//		input [3:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [23:0] data_Out
//);
//
//logic [23:0] mem [0:15];
//
//initial 
//begin
//	$readmemh("spriteBytes/backgroundPalette.txt", mem);
//end
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out <= mem[read_address];
//end
//
//endmodule
