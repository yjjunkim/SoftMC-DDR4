`timescale 1ns / 1ps

`include "softMC.inc"

module instr_decoder #(parameter ROW_WIDTH = 15, BANK_WIDTH = 3, CS_WIDTH = 1)(
	input en,
	input[31:0] instr,
	
	output reg[ROW_WIDTH*8-1:0] dfi_address,
	output reg[BANK_WIDTH*8 - 1:0] dfi_bank,
	output reg[7:0] dfi_bankgroup,
	
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
    
    // for address loop
    integer idx, i;
    
    reg [2:0] addr_add;
	always@* begin
		dfi_address = {ROW_WIDTH*8{1'bx}};
		dfi_bank = {BANK_WIDTH*8{1'bx}};
		dfi_bankgroup = {8{1'bx}};
		
		dfi_cas_n = HIGH;
		dfi_cs_n = {8{HIGH}};
		dfi_ras_n = HIGH;
		dfi_we_n = HIGH;
		// jun
		mc_ACT_n = {8{HIGH}};
		mcRdCAS = 1'b0;
		mcWrCAS = 1'b0;
		
		if(en) begin // host 에서 오는 instr 사용
	        addr_add = {instr[`RAS_OFFSET], instr[`CAS_OFFSET], instr[`WE_OFFSET]};
	        //dfi_address = instr[ROW_WIDTH - 1:0]; 원래 addr 코드
			// RAS, CAS, WE를 추가해주는 것이 아니라 , 0으로 채워서 전송해줘야하지 않을까
			// SOFTMC에서 ROW ADDR을 채워서 보내주는 것이 아니므로
			
			dfi_we_n = instr[`WE_OFFSET];
			dfi_cas_n = instr[`CAS_OFFSET];
			dfi_ras_n = instr[`RAS_OFFSET];
			//dfi_address = {{ROW_WIDTH*6{1'b1}}, {2{instr[ROW_WIDTH - 1:0]}}}; // MSB *6 ROWWIDTH만큼  1으로 채우기, , INSTR 2번 COPY
			
			// ACT_n이 LOW이면 row address로 쓰이므로 0으로 전달.
			//dfi_address[135:128] <= ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? {{6{1'b1}}, 2'b00}  : {6'b111111, instr[`RAS_OFFSET], instr[`RAS_OFFSET]};
			dfi_address[135:128] <= ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? {8{1'b0}}  : {6'b111111, instr[`RAS_OFFSET], instr[`RAS_OFFSET]};
			dfi_address[127:120] <= ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? {8{1'b0}}  : {6'b111111, instr[`CAS_OFFSET], instr[`CAS_OFFSET]};
			dfi_address[119:112] <= ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? {8{1'b0}}  : {6'b111111, instr[`WE_OFFSET], instr[`WE_OFFSET]};
			
			//dfi_address[111:0] <= 1;
			//dfi_address[(idx+1)* 8] = {6'b000000, instr[idx], instr[idx]};
			for(idx = 0; idx < ROW_WIDTH - 3; idx = idx + 1)begin
			  //dfi_address[(idx+1)*8 +:6] = 6'b000000;
  
			  dfi_address[(idx+1)* 8-1] = 1'b0;
			  dfi_address[(idx+1)* 8-2] = 1'b0;
			  dfi_address[(idx+1)* 8-3] = 1'b0;
			  dfi_address[(idx+1)* 8-4] = 1'b0;
			  dfi_address[(idx+1)* 8-5] = 1'b0;
			  dfi_address[(idx+1)* 8-6] = 1'b0;
			  dfi_address[(idx+1)* 8-7] = instr[idx];
			  dfi_address[(idx+1)* 8-8] = instr[idx];
			end
			// jun bank  
			//dfi_bank = {{BANK_WIDTH*6{1'b1}}, instr[`ROW_OFFSET +: BANK_WIDTH],instr[`ROW_OFFSET +: BANK_WIDTH]}; // MSB *6 BANKWIDTH만큼 1으로 채우기, INSTR 2번 COPY
			for(i = 0; i < BANK_WIDTH ; i = i + 1)begin
			   dfi_bank[(i+1)*8 - 1] = 1'b0;
			   dfi_bank[(i+1)*8 - 2] = 1'b0;
			   dfi_bank[(i+1)*8 - 3] = 1'b0;
			   dfi_bank[(i+1)*8 - 4] = 1'b0;
			   dfi_bank[(i+1)*8 - 5] = 1'b0;
			   dfi_bank[(i+1)*8 - 6] = 1'b0;
			   dfi_bank[(i+1)*8 - 7] = instr[`ROW_OFFSET + i];
			   dfi_bank[(i+1)*8 - 8] = instr[`ROW_OFFSET + i];
			end
			
			dfi_bankgroup = 8'b00000011;
			
			// bg, TOP에서 LST 2bit 0으로 TIE 해두었음 
			// odt "instr_dispatcher"에서 assign	
			// jun L H H -> ACT_n => LOW
			// act
			mc_ACT_n = ((~dfi_ras_n)&(dfi_cas_n)&(dfi_we_n)) ? 8'b11111100 : 8'b11111111;
			
			//jun : RdCAS, WrCAS
			//mcRdCAS = ((dfi_ras_n)&(~dfi_cas_n)&(dfi_we_n)) ? 1'b1 : 1'b0;
			//mcWrCAS = ((dfi_ras_n)&(~dfi_cas_n)&(~dfi_we_n)) ? 1'b1 : 1'b0;
			
			mcRdCAS = ((dfi_ras_n)&(~dfi_cas_n)&(dfi_we_n)&(mc_ACT_n)) ? 1'b1 : 1'b0;
			mcWrCAS = ((dfi_ras_n)&(~dfi_cas_n)&(~dfi_we_n)&(mc_ACT_n)) ? 1'b1 : 1'b0;
			
			dfi_cs_n = {{6{1'b1}},instr[`CS_OFFSET +: CS_WIDTH] ,instr[`CS_OFFSET +: CS_WIDTH]}; // MSB 6BIT 1로 채우기, INSTR 2번 COPY
		end //en
	end
endmodule
