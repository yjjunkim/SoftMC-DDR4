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
    output wire [C_DATA_WIDTH-1:0] s_axis_c2h_tdata_0,  
    output wire s_axis_c2h_tlast_0,
    //output wire s_axis_c2h_tvalid_0,
    output reg s_axis_c2h_tvalid_0,
    input  wire s_axis_c2h_tready_0,
    output wire [C_DATA_WIDTH/8-1:0] s_axis_c2h_tkeep_0, // [15:0]
    //input  wire [C_DATA_WIDTH-1:0] m_axis_h2c_tdata_0,
    input  wire [31:0] m_axis_h2c_tdata_0,  // softMC : PCI_DATA_WIDTH
    //input  wire [128:0] m_axis_h2c_tdata_0,  // softMC : PCI_DATA_WIDTH
    input  wire m_axis_h2c_tlast_0,
    input  wire m_axis_h2c_tvalid_0,
    output wire m_axis_h2c_tready_0,
    input  wire [C_DATA_WIDTH/8-1:0] m_axis_h2c_tkeep_0,

  // System IO signals
  input  wire         user_resetn,
  input  wire         sys_rst_n,
 
  input  wire         user_clk,
  input  wire         user_lnk_up,
  //output wire   [3:0] leds,
  output reg   [2:0] leds,
  
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
  reg  [25:0]     user_clk_heartbeat;
  
  ////// softmc Port list ///////
  reg app_en_r;
  reg[31:0] rx_data_r;
  
  //softmc led test
  
  always @(posedge user_clk)begin
    if(!sys_resetn)begin
        leds = 3'b111;
    end
    else if(m_axis_h2c_tdata_0 == {128{1'b1}})begin
        leds = 3'b000;
    end
  end
  


  // The sys_rst_n input is active low based on the core configuration
  assign sys_resetn = sys_rst_n;

  // Create a Clock Heartbeat
  always @(posedge user_clk) begin
    if(!sys_resetn) begin
      user_clk_heartbeat <= #TCQ 26'd0;
    end else begin
      user_clk_heartbeat <= #TCQ user_clk_heartbeat + 1'b1;
    end
  end

  // LEDs for observation
  //assign leds[0] = sys_resetn;
  //assign leds[1] = user_resetn;
  //assign leds[2] = user_lnk_up;
  //assign leds[3] = user_clk_heartbeat[25];

      // AXI streaming portss
      /*
      //assign s_axis_c2h_tdata_0 =  m_axis_h2c_tdata_0;   
      assign s_axis_c2h_tdata_0 =  {128{1'b1}};  
      //assign s_axis_c2h_tlast_0 =  m_axis_h2c_tlast_0;
      assign s_axis_c2h_tlast_0 =  1'b1;
      //assign s_axis_c2h_tvalid_0 =  m_axis_h2c_tvalid_0;  
      assign s_axis_c2h_tvalid_0 =  1'b1; 
      //assign s_axis_c2h_tkeep_0 =  m_axis_h2c_tkeep_0;  
      assign s_axis_c2h_tkeep_0 = 16'b1111111111111111;
      //assign m_axis_h2c_tready_0 = s_axis_c2h_tready_0;
      assign m_axis_h2c_tready_0 = 1'b1;
      */
      
      
      ////////////softMC signal : Direct connection//////////
      /*
      //assign s_axis_c2h_tkeep_0 =  m_axis_h2c_tkeep_0;   // ?
      assign s_axis_c2h_tkeep_0 = 16'b1111111111111111;
      
      /////h2c : host to card - RX/////
      assign app_en = m_axis_h2c_tvalid_0;
      assign app_instr = m_axis_h2c_tdata_0;
      
      assign m_axis_h2c_tready_0 = app_ack;
      //assign m_axis_h2c_tlast_0 = 1'b1;
      
      /////c2h : card to host - TX/////
      assign s_axis_c2h_tvalid_0 = ~rdback_fifo_empty;
      assign s_axis_c2h_tdata_0 = rdback_data;
      
      assign rdback_fifo_rden = s_axis_c2h_tready_0;
      assign s_axis_c2h_tlast_0 = 1'b1;
      */
      
      
      //////// softMC signal : reg connection /////////////
      assign s_axis_c2h_tkeep_0 = 16'b1111111111111111;
      assign s_axis_c2h_tlast_0 =  m_axis_h2c_tlast_0;
      
      assign m_axis_h2c_tready_0 = ~app_en_r | app_ack;
      always@(posedge user_clk)begin
            if(~app_en_r | app_ack) begin
                app_en_r <= m_axis_h2c_tvalid_0;
                rx_data_r <= m_axis_h2c_tdata_0;
            end
      end
      //send to the MC
      assign app_en = app_en_r;
      assign app_instr = rx_data_r;
      
      //SEND DATA TO HOST
      localparam RECV_IDLE = 1'b0;
      localparam RECV_BUSY = 1'b1;
      
      reg sender_ack;
      reg[511:0] send_data_r;
      
      reg recv_state = RECV_IDLE;
      assign rdback_fifo_rden = (recv_state == RECV_IDLE);
      always@(posedge user_clk) begin
            if(!sys_rst_n) begin // rst n?
                recv_state <= RECV_IDLE;
            end
            else begin
                case(recv_state)
                    RECV_IDLE: begin
                        if(~rdback_fifo_empty) begin
                            send_data_r <= rdback_data;
                            //send_data_r <= {512{1'b1}};
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
        
        
        reg[2:0] sender_state = 0; //edit this if DQ_WIDTH or C_PCI_DATA_WIDTH changes
        reg[2:0] sender_state_ns;
        
        //reg s_axis_c2h_tvalid_0; // softmc : for always statements
        
        always@* begin
            sender_ack = 1'b0;
            sender_state_ns = sender_state;
            //CHNL_TX = sender_state[2];
            
            //CHNL_TX_LEN = 16;
            
            if(recv_state == RECV_BUSY) begin
                //CHNL_TX = 1'b1;
                //CHNL_TX_DATA_VALID = 1'b1;
                s_axis_c2h_tvalid_0 = 1'b1;
                
                //if(CHNL_TX_DATA_REN) begin
                if(s_axis_c2h_tready_0) begin
                    sender_state_ns = sender_state + 3'd1;
                    
                    if(sender_state[1:0] == 2'b11)
                        sender_ack = 1'b1;
                end
            end
        end
      
    always@(posedge user_clk) begin
        if(!sys_resetn) begin
            sender_state <= 0;
        end
        else begin
            sender_state <= sender_state_ns;
        end
    end

    //wire[7:0] offset = {6'd0, sender_state[1:0]} << 6;
    //assign CHNL_TX_DATA = send_data_r[offset +: 64];  
    //wire[7:0] offset = {7'd0, sender_state[1:0]} << 7;
    wire[8:0] offset = {7'd0, sender_state[1:0]} << 7;
    assign s_axis_c2h_tdata_0 = send_data_r[offset +: 128];
    
    //assign s_axis_c2h_tdata_0 = m_axis_h2c_tdata_0;
    
      




endmodule
