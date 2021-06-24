`timescale 1ns / 1ps

`include "softMC.inc"

module instr_decoder #(parameter ROW_WIDTH = 15, BANK_WIDTH = 3, CS_WIDTH = 1)(
	input en,
	input[31:0] instr,
	
	output reg[ROW_WIDTH*8-1:0] dfi_address,
	output reg[BANK_WIDTH*8 - 1:0] dfi_bank,
	output reg dfi_cas_n,
	output reg[7:0] dfi_cs_n,
	output reg dfi_ras_n,
	output reg dfi_we_n,
	
	// jun ACT_n
	output reg [7:0] mc_ACT_n,
	output reg mcRdCAS,
	output reg mcWrCAS
	
);
	
	localparam LOW = 1'b0;
	localparam HIGH = 1'b1;
    // 6'b1 concat : jun
    localparam tmp_slot = {ROW_WIDTH*8{1'b1}};
	always@* begin
		dfi_address = {ROW_WIDTH*8{1'bx}};
		dfi_bank = {BANK_WIDTH*8{1'bx}};
		
		dfi_cas_n = HIGH;
		dfi_cs_n = {8{HIGH}};
		dfi_ras_n = HIGH;
		dfi_we_n = HIGH;
		// jun
		mc_ACT_n = {8{HIGH}};
		if(en) begin // host 에서 오는 instr 사용
			dfi_address = {{ROW_WIDTH*6{1'b1}}, instr[ROW_WIDTH - 1:0] ,instr[ROW_WIDTH - 1:0]}; // MSB *6 ROWWIDTH만큼  1으로 채우기, INSTR 2번 COPY
			dfi_bank = {{BANK_WIDTH*6{1'b1}}, instr[`ROW_OFFSET +: BANK_WIDTH],instr[`ROW_OFFSET +: BANK_WIDTH]}; // MSB *6 BANKWIDTH만큼 1으로 채우기, INSTR 2번 COPY
			// bg, TOP에서 LST 2bit 0으로 TIE 해두었음 
			// act
			// odt
			dfi_we_n = instr[`WE_OFFSET];
			dfi_cas_n = instr[`CAS_OFFSET];
			dfi_ras_n = instr[`RAS_OFFSET];
			
			// jun L H H -> ACT_n => LOW
			mc_ACT_n = ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? 8'b11111100 : 8'b11111111;
			
			mcRdCAS = ((dfi_ras_n)&(~dfi_cas_n)&(dfi_we_n)) ? 1'b1 : 1'b0;
			mcWrCAS = ((dfi_ras_n)&(~dfi_cas_n)&(~dfi_we_n)) ? 1'b1 : 1'b0;
			
			dfi_cs_n = {{6{1'b1}},instr[`CS_OFFSET +: CS_WIDTH] ,instr[`CS_OFFSET +: CS_WIDTH]}; // MSB 6BIT 1로 채우기, INSTR 2번 COPY
		end //en
	end
endmodule
