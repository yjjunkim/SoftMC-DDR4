`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/31 07:11:25
// Design Name: 
// Module Name: fake_pcie
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fake_pcie(
    input axi_clk,
    input axi_rst_n,
    output axi_valid,
    output [31:0] axi_data,
    input axi_ready
    );
    
    reg [31:0] mem [1023:0];
    
    initial begin
        
    
    always@(posedge axi_clk)begin
       if(~axi_rst_n) 
endmodule
