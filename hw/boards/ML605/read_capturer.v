`timescale 1ns / 1ps

module read_capturer #(parameter DQ_WIDTH = 64) (
	input clk,
	input rst,
	
	//DFI Interface
	//input  [4*DQ_WIDTH-1:0] dfi_rddata,
	input  [511:0] dfi_rddata,
	input                   dfi_rddata_valid,
	input							dfi_rddata_valid_even,
	input							dfi_rddata_valid_odd,
	output						dfi_clk_disable,
	
	//FIFO interface
	input rdback_fifo_almost_full,
	input rdback_fifo_full,
	output rdback_fifo_wren,
	//output[4*DQ_WIDTH-1:0] rdback_fifo_wrdata
	output [511:0] rdback_fifo_wrdata
	
);

	//reg[4*DQ_WIDTH-1:0] rd_data_r, rd_data_r2;
	reg[511:0] rd_data_r, rd_data_r2;
	reg rd_data_en_r, rd_data_en_even_r, rd_data_en_odd_r;
	reg rdback_fifo_full_r;
	
	//add reg output jun
	//reg rdback_fifo_wren;
	//reg[511:0] rdback_fifo_wrdata;
	
	always@(posedge clk) begin
		if(rst) begin
			rd_data_r <= 0;
			rd_data_r2 <= 0;
			rd_data_en_r <= 0;
			rd_data_en_even_r <= 0;
			rd_data_en_odd_r <= 0;
			rdback_fifo_full_r <= 0;
		end
		else begin
			rd_data_r <= dfi_rddata;
			rd_data_r2 <= rd_data_r;
			rd_data_en_r <= dfi_rddata_valid;
			rd_data_en_even_r <= dfi_rddata_valid_even;
			rd_data_en_odd_r <= dfi_rddata_valid_odd;
			
			rdback_fifo_full_r <= rdback_fifo_almost_full | rdback_fifo_full;
			
			// posclk 에서만 전달되도록 수정 
			//rdback_fifo_wren <= dfi_rddata_valid;
			//rdback_fifo_wrdata <= dfi_rddata;
			
		end
	end
	
	//assign rdback_fifo_wren = ~rd_data_en_odd_r & rd_data_en_r;
	//assign rdback_fifo_wrdata = rd_data_en_even_r ? {rd_data_r[DQ_WIDTH*2 - 1:0], rd_data_r2[DQ_WIDTH*2 +: DQ_WIDTH*2]} : rd_data_r;
	
	// jun : odd, even condtion 무시하고 직접 dfi signal 전달.
	assign rdback_fifo_wren = dfi_rddata_valid;
	assign rdback_fifo_wrdata = dfi_rddata;
	
	assign dfi_clk_disable = rdback_fifo_full_r;

endmodule
