//-----------------------------------------------------------------------------
//
// (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
//
// Project    : The Xilinx PCI Express DMA 
// File       : xdma_app.v
// Version    : 4.1
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps
module xdma_app #(
  parameter TCQ                         = 1,
  parameter C_M_AXI_ID_WIDTH            = 4,
  parameter PL_LINK_CAP_MAX_LINK_WIDTH  = 8,
  //parameter C_DATA_WIDTH                = 64,
  //parameter C_DATA_WIDTH                = 256,
  parameter C_DATA_WIDTH                = 128,
  parameter C_M_AXI_DATA_WIDTH          = C_DATA_WIDTH,
  parameter C_S_AXI_DATA_WIDTH          = C_DATA_WIDTH,
  parameter C_S_AXIS_DATA_WIDTH         = C_DATA_WIDTH,
  parameter C_M_AXIS_DATA_WIDTH         = C_DATA_WIDTH,
  parameter C_M_AXIS_RQ_USER_WIDTH      = ((C_DATA_WIDTH == 512) ? 137 : 62),
  parameter C_S_AXIS_CQP_USER_WIDTH     = ((C_DATA_WIDTH == 512) ? 183 : 88),
  parameter C_M_AXIS_RC_USER_WIDTH      = ((C_DATA_WIDTH == 512) ? 161 : 75),
  parameter C_S_AXIS_CC_USER_WIDTH      = ((C_DATA_WIDTH == 512) ?  81 : 33),
  parameter C_S_KEEP_WIDTH              = C_S_AXI_DATA_WIDTH / 32,
  parameter C_M_KEEP_WIDTH              = (C_M_AXI_DATA_WIDTH / 32),
  parameter C_XDMA_NUM_CHNL             = 1
)
(


//VU9P_TUL_EX_String= FALSE


      // AXI streaming ports
    output reg [C_DATA_WIDTH-1:0] s_axis_c2h_tdata_0,  
    output wire s_axis_c2h_tlast_0,
    //output reg s_axis_c2h_tlast_0,
    output reg s_axis_c2h_tvalid_0,
    //output reg s_axis_c2h_tvalid_0,
    input  wire s_axis_c2h_tready_0,
    output wire [C_DATA_WIDTH/8-1:0] s_axis_c2h_tkeep_0, // [15:0]
    
    input  wire [C_DATA_WIDTH-1:0] m_axis_h2c_tdata_0,
    //input  wire [31:0] m_axis_h2c_tdata_0,  // softMC : PCI_DATA_WIDTH
    //input  wire [128:0] m_axis_h2c_tdata_0,  // softMC : PCI_DATA_WIDTH
    input  wire m_axis_h2c_tlast_0,
    input  wire m_axis_h2c_tvalid_0,
    output reg m_axis_h2c_tready_0,
    input  wire [C_DATA_WIDTH/8-1:0] m_axis_h2c_tkeep_0,
    
    //input wire [31:0] return_app_instr,

  // System IO signals
  input wire axi_clk,
  input  wire         axi_rst_n,
  
  input  wire         softmc_clk,
  input wire softmc_rst,
  
  
  //output wire   [3:0] leds,
  output  [2:0] leds,
  
  ///////////softMC///////////////////
  output  app_en,
  input app_ack,
  output[31:0] app_instr,
	
  //Data read back Interface
  input rdback_fifo_empty,
  output rdback_fifo_rden,
  input[511:0] rdback_data

);
  // wire/reg declarations
  wire            sys_reset;
  
  ////// softmc Port list ///////
  reg app_en_r;
  //reg[31:0] rx_data_r;
  reg[C_DATA_WIDTH-1:0] rx_data_r;
  
  reg m_axis_h2c_tvalid_w;
  wire m_axis_h2c_tready_w;
  reg [C_DATA_WIDTH-1:0] m_axis_h2c_tdata_w;
  
  //wire s_axis_c2h_tvalid_r;
  reg s_axis_c2h_tvalid_r;
  reg s_axis_c2h_tready_r;
  wire [C_DATA_WIDTH-1:0] s_axis_c2h_tdata_r;
  
  // clock convert rest test
  assign leds[0] = softmc_rst;
  assign leds[1] = ~axi_rst_n;

      //////// softMC signal : reg connection /////////////
      assign s_axis_c2h_tkeep_0 = 16'b1111111111111111;
      assign s_axis_c2h_tlast_0 =  1'b1;
      
   
      assign m_axis_h2c_tready_w = ~app_en_r | app_ack;
      always@(posedge softmc_clk)begin // app_en_r 초기화 취소 0730
                if(softmc_rst) begin
                    app_en_r <=1'b0;
                end
                else if(~app_en_r | app_ack) begin
                    app_en_r <= m_axis_h2c_tvalid_w;
                    rx_data_r <= m_axis_h2c_tdata_w;
                end
      end
      //send to the MC
      assign app_en = app_en_r;
      assign app_instr = rx_data_r;
      
      //SEND DATA TO HOST
      localparam RECV_IDLE = 1'b0;
      localparam RECV_BUSY = 1'b1;
      
      reg sender_ack;
      //reg[511:0] send_data_r;
      reg[511:0] send_data_r;
      
      reg recv_state = RECV_IDLE;
      assign rdback_fifo_rden = (recv_state == RECV_IDLE);
      always@(posedge softmc_clk) begin
            if(softmc_rst) begin // rst n?
                recv_state <= RECV_IDLE;
                send_data_r <= 512'b0;
               // s_axis_c2h_tvalid_r = 1'b0;
            end
            else begin
                case(recv_state)
                    RECV_IDLE: begin
                        if(~rdback_fifo_empty) begin
                            send_data_r <= rdback_data;
                            recv_state <= RECV_BUSY;
                        end
                    end //RECV_IDLE
                    
                    RECV_BUSY: begin
                        if(sender_ack)
                            recv_state <= RECV_IDLE;
                    end //RECV_BUSY
                endcase
            end
        end
        
        
        //64 bit width
        //reg[3:0] sender_state = 0; //edit this if DQ_WIDTH or C_PCI_DATA_WIDTH changes
        //reg[3:0] sender_state_ns;
        
        //256bit width
        //reg[1:0] sender_state = 0; //edit this if DQ_WIDTH or C_PCI_DATA_WIDTH changes
        //reg[1:0] sender_state_ns;
        
        //128bit width
        reg[2:0] sender_state = 0; //edit this if DQ_WIDTH or C_PCI_DATA_WIDTH changes
        reg[2:0] sender_state_ns;
        
        //reg sender_state = 0; //edit this if DQ_WIDTH or C_PCI_DATA_WIDTH changes
        //reg sender_state_ns;
        
         //sendaer state 왜 한비트 추가?
        
        always@* begin
            sender_ack = 1'b0;
            sender_state_ns = sender_state;
            s_axis_c2h_tvalid_r = 1'b0;
             
            if(recv_state == RECV_BUSY) begin
                s_axis_c2h_tvalid_r = 1'b1;
                
                if(s_axis_c2h_tready_r) begin
                    sender_state_ns = sender_state + 3'd1;
                    
                    if(sender_state[1:0] ==  2'b11)begin
                        sender_ack = 1'b1;
                    end
                end
            end
        end
      
    always@(posedge softmc_clk) begin
        if(softmc_rst) begin
            sender_state <= 0;
        end
        else begin
            sender_state <= sender_state_ns;
        end
    end


    
    //wire[8:0] offset = {8'd0, sender_state} << 8;
    //assign s_axis_c2h_tdata_r = send_data_r[offset +: 256];
    
    //wire[8:0] offset = {6'd0, sender_state[2:0]} << 6;
    //assign s_axis_c2h_tdata_r = send_data_r[offset +: 128];
    
    wire[8:0] offset = {7'd0, sender_state[1:0]} << 7;
    assign s_axis_c2h_tdata_r = send_data_r[offset +: 128];
    
    //wire[8:0] offset = {6'd0, sender_state[2:0]} << 6;
    //assign s_axis_c2h_tdata_r = send_data_r[offset +: 64];
    //assign s_axis_c2h_tdata_r = send_data_r[0 +: 64];
    
     reg m_axis_h2c_tvalid_n;
     reg [127:0]m_axis_h2c_tdata_n;
     reg m_axis_h2c_tready_n;
   
     reg s_axis_c2h_tvalid_n;
     reg [127:0] s_axis_c2h_tdata_n;
     reg s_axis_c2h_tready_n;
     
    //SOFTMC-->PCIE  
    always@(posedge softmc_clk)begin
        if(softmc_rst)begin
            m_axis_h2c_tdata_n=0;
            m_axis_h2c_tvalid_n=0;
            s_axis_c2h_tready_n=0;
        end
        else begin
            m_axis_h2c_tdata_n=#1 m_axis_h2c_tdata_0;
            m_axis_h2c_tvalid_n=#1 m_axis_h2c_tvalid_0;
            s_axis_c2h_tready_n=#1 s_axis_c2h_tready_0;
        end
    end
    
      always@(posedge softmc_clk)
      begin
        m_axis_h2c_tdata_w=#1 m_axis_h2c_tdata_n;
           m_axis_h2c_tvalid_w=#1 m_axis_h2c_tvalid_n;
           s_axis_c2h_tready_r=#1 s_axis_c2h_tready_n;
       end
       
    
      //PCIE--> SOFTMC    
      always@(posedge axi_clk)begin
        if(~axi_rst_n)begin
            s_axis_c2h_tdata_n=0;
            s_axis_c2h_tvalid_n=0;
            m_axis_h2c_tready_n=0;
        end
        else begin
            s_axis_c2h_tdata_n=#1 s_axis_c2h_tdata_r;
            s_axis_c2h_tvalid_n=#1 s_axis_c2h_tvalid_r;
            m_axis_h2c_tready_n=#1 m_axis_h2c_tready_w;
        end
    end
    
      always@(posedge axi_clk)
      begin
           s_axis_c2h_tdata_0=#1 s_axis_c2h_tdata_n;
           s_axis_c2h_tvalid_0=#1 s_axis_c2h_tvalid_n;
           m_axis_h2c_tready_0=#1 m_axis_h2c_tready_n;
       end
    
    
       
   // assign m_axis_h2c_tvalid_w=m_axis_h2c_tvalid_0;
 //   assign m_axis_h2c_tdata_w=m_axis_h2c_tdata_0;
 //   assign m_axis_h2c_tready_0=m_axis_h2c_tready_w;
    
   // assign s_axis_c2h_tvalid_0=s_axis_c2h_tvalid_r;
   // assign s_axis_c2h_tdata_0=s_axis_c2h_tdata_r;
  //  assign s_axis_c2h_tready_r=s_axis_c2h_tready_0;
    
   /* axis_clock_converter_0 H2C_CONVERT(
      //.s_axis_aresetn(1'b0),
      //.m_axis_aresetn(1'b0),
      
      .s_axis_aresetn(axi_rst_n),
      .m_axis_aresetn(~softmc_rst),
      .s_axis_aclk(axi_clk), // in
      .m_axis_aclk(softmc_clk), // in
           
      .s_axis_tvalid(m_axis_h2c_tvalid_0), // in
      .s_axis_tready(m_axis_h2c_tready_0), // out
      .s_axis_tdata(m_axis_h2c_tdata_0),  // in

      .m_axis_tvalid(m_axis_h2c_tvalid_w),  // out
      .m_axis_tready(m_axis_h2c_tready_w),  // in
      .m_axis_tdata(m_axis_h2c_tdata_w)  // out
    );
    
    
      axis_clock_converter_0 C2H_CONVERT(
      //.s_axis_aresetn(1'b0),
      //.m_axis_aresetn(1'b0),
      
      
      .s_axis_aresetn(~softmc_rst),
      .m_axis_aresetn(axi_rst_n),
      .s_axis_aclk(softmc_clk), // in
      .m_axis_aclk(axi_clk),        // in
      
      .s_axis_tvalid(s_axis_c2h_tvalid_r), // in
      .s_axis_tready(s_axis_c2h_tready_r), // out
      .s_axis_tdata(s_axis_c2h_tdata_r),  // in
     // .s_axis_tdata(tmep_data),  // in
      .m_axis_tvalid(s_axis_c2h_tvalid_0), // out
      .m_axis_tready(s_axis_c2h_tready_0), // in
      .m_axis_tdata(s_axis_c2h_tdata_0)  // out
    );*/
    
endmodule
