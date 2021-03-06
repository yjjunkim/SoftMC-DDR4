`timescale 1ps / 1ps

`include "softMC.inc"
`ifdef XILINX_SIMULATOR
module short(in1, in1);
inout in1;
endmodule
`endif


module tb_softMC_top;
	
  //parameter REFCLK_FREQ           = 200;
  parameter REFCLK_FREQ           = 100;
  parameter PCIE_USER_CLK         = 250;
                                    // # = 200 for all design frequencies of
                                    //         -1 speed grade devices
                                    //   = 200 when design frequency < 480 MHz
                                    //         for -2 and -3 speed grade devices.
                                    //   = 300 when design frequency >= 480 MHz
                                    //         for -2 and -3 speed grade devices.
  //parameter SIM_BYPASS_INIT_CAL   = "FAST";
  parameter SIM_BYPASS_INIT_CAL   = "OFF";
                                    // # = "OFF" -  Complete memory init &
                                    //              calibration sequence
                                    // # = "SKIP" - Skip memory init &
                                    //              calibration sequence
                                    // # = "FAST" - Skip memory init & use
                                    //              abbreviated calib sequence
  parameter RST_ACT_LOW           = 0;
  //parameter RST_ACT_LOW           = 1;
                                    // =1 for active low reset,
                                    // =0 for active fhigh.
  parameter IODELAY_GRP           = "IODELAY_MIG";
                                    //to phy_top
 //MODIFIED by SH, 07
 // parameter nCK_PER_CLK           = 2;
   parameter nCK_PER_CLK           = 4;
                                    // # of memory CKs per fabric clock.
                                    // # = 2, 1.
  parameter nCS_PER_RANK          = 1;
                                    // # of unique CS outputs per Rank for
                                    // phy.
  parameter DQS_CNT_WIDTH         = 3;
                                    // # = ceil(log2(DQS_WIDTH)).
  parameter RANK_WIDTH            = 1;
                                    // # = ceil(log2(RANKS)).
  parameter BANK_WIDTH            = 2;
                                    // # of memory Bank Address bits.
  parameter CK_WIDTH              = 2;
                                    // # of CK/CK# outputs to memory.
  parameter CKE_WIDTH             = 1;
                                    // # of CKE outputs to memory.
  parameter COL_WIDTH             = 10;
                                    // # of memory Column Address bits.
  parameter CS_WIDTH              = 1;
                                    // # of unique CS outputs to memory.
  parameter DM_WIDTH              = 8;
                                    // # of Data Mask bits.
  parameter DQ_WIDTH              = 64;
                                    // # of Data (DQ) bits.
  parameter DQS_WIDTH             = 8;
                                    // # of DQS/DQS# bits.
  parameter ROW_WIDTH             = 17;
  //parameter ROW_WIDTH             = 16;
                                    // # of memory Row Address bits.
  parameter BURST_MODE            = "8";
                                    // Burst Length (Mode Register 0).
                                    // # = "8", "4", "OTF".
  parameter INPUT_CLK_TYPE        = "DIFFERENTIAL";
                                    // input clock type DIFFERENTIAL or SINGLE_ENDED
  parameter BM_CNT_WIDTH          = 2;
                                    // # = ceil(log2(nBANK_MACHS)).
  parameter ADDR_CMD_MODE         = "1T" ;
                                    // # = "2T", "1T".
  parameter ORDERING              = "STRICT";
                                    // # = "NORM", "STRICT".
  parameter RTT_NOM               = "60";
                                    // RTT_NOM (ODT) (Mode Register 1).
                                    // # = "DISABLED" - RTT_NOM disabled,
                                    //   = "120" - RZQ/2,
                                    //   = "60" - RZQ/4,
                                    //   = "40" - RZQ/6.
   parameter RTT_WR               = "OFF";
                                       // RTT_WR (ODT) (Mode Register 2).
                                       // # = "OFF" - Dynamic ODT off,
                                       //   = "120" - RZQ/2,
                                       //   = "60" - RZQ/4,
  parameter OUTPUT_DRV            = "HIGH";
                                    // Output Driver Impedance Control (Mode Register 1).
                                    // # = "HIGH" - RZQ/7,
                                    //   = "LOW" - RZQ/6.
  parameter REG_CTRL              = "OFF";
                                    // # = "ON" - RDIMMs,
                                    //   = "OFF" - Components, SODIMMs, UDIMMs.
  parameter CLKFBOUT_MULT_F       = 14;
  //parameter CLKFBOUT_MULT_F       = 6;
                                    // write PLL VCO multiplier.
  parameter DIVCLK_DIVIDE         = 1;
                                    // write PLL VCO divisor.
  //parameter CLKOUT_DIVIDE         = 3;
  parameter CLKOUT_DIVIDE         = 7;
                                    // VCO output divisor for fast (memory) clocks.
  //parameter tCK                   = 2500;
  //parameter tCK                   = 2499;
  parameter tCK                   = 1250;
                                    // memory tCK paramter.
                                    // # = Clock Period.
  parameter DEBUG_PORT            = "OFF";
                                    // # = "ON" Enable debug signals/controls.
                                    //   = "OFF" Disable debug signals/controls.
  parameter tPRDI                   = 1_000_000;
                                    // memory tPRDI paramter.
  parameter tREFI                   = 7800000;
                                    // memory tREFI paramter.
  parameter tZQI                    = 128_000_000;
                                    // memory tZQI paramter.
  //parameter ADDR_WIDTH              = 29;
                                    // # = RANK_WIDTH + BANK_WIDTH
                                    //     + ROW_WIDTH + COL_WIDTH;
  parameter STARVE_LIMIT            = 2;
                                    // # = 2,3,4.
  parameter TCQ                     = 100;
  parameter ECC                     = "OFF";
  parameter ECC_TEST                = "OFF";
  parameter DATA_WIDTH              = 64;
  parameter PAYLOAD_WIDTH           = (ECC_TEST == "OFF") ? DATA_WIDTH : DQ_WIDTH;


  //***********************************************************************//
  // Traffic Gen related parameters
  //***********************************************************************//
  parameter EYE_TEST                = "FALSE";
                                      // set EYE_TEST = "TRUE" to probe memory
                                      // signals. Traffic Generator will only
                                      // write to one single location and no
                                      // read transactions will be generated.

  parameter SIMULATION              = "TRUE";
  // PRBS_DATA_MODE can only be used together with either PRBS_ADDR or SEQUENTIAL_ADDR
  // FIXED_DATA_MODE is designed to work with FIXED_ADDR
  parameter ADDR_MODE               = 3;
                                      //FIXED_ADDR      = 2'b01;
                                      //PRBS_ADDR       = 2'b10;
                                      //SEQUENTIAL_ADDR = 2'b11;
  parameter DATA_MODE               = 2;  // To change simulation data pattern
                                      // FIXED_DATA_MODE       =    4'b0001;
                                      // ADDR_DATA_MODE        =    4'b0010;
                                      // HAMMER_DATA_MODE      =    4'b0011;
                                      // NEIGHBOR_DATA_MODE    =    4'b0100;
                                      // WALKING1_DATA_MODE    =    4'b0101;
                                      // WALKING0_DATA_MODE    =    4'b0110;
                                      // PRBS_DATA_MODE        =    4'b0111;
  parameter TST_MEM_INSTR_MODE      = "R_W_INSTR_MODE";
                                      // available instruction modes:
                                      //"FIXED_INSTR_R_MODE"
                                      // "FIXED_INSTR_W_MODE"
                                      // "R_W_INSTR_MODE"
  parameter DATA_PATTERN            = "DGEN_ALL";
                                      // DATA_PATTERN shoule be set to "DGEN_ALL"
                                      // unless it is targeted for S6 small device.
                                      // "DGEN_HAMMER", "DGEN_WALKING1",
                                      // "DGEN_WALKING0","DGEN_ADDR","
                                      // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
  parameter CMD_PATTERN             = "CGEN_ALL";
                                      // CMD_PATTERN shoule be set to "CGEN_ALL"
                                      // unless it is targeted for S6 small device.
                                      // "CGEN_RPBS","CGEN_FIXED","CGEN_BRAM",
                                      // "CGEN_SEQUENTIAL", "CGEN_ALL"

  parameter BEGIN_ADDRESS           = 32'h00000000;
  parameter PRBS_SADDR_MASK_POS     = 32'h00000000;
  parameter END_ADDRESS             = 32'h000003ff;
  parameter PRBS_EADDR_MASK_POS     = 32'hfffffc00;
  parameter SEL_VICTIM_LINE         = 11;

  //**************************************************************************//
  // Local parameters Declarations
  //**************************************************************************//
  localparam real TPROP_DQS          = 0.00;  // Delay for DQS signal during Write Operation
  localparam real TPROP_DQS_RD       = 0.00;  // Delay for DQS signal during Read Operation
  localparam real TPROP_PCB_CTRL     = 0.00;  // Delay for Address and Ctrl signals
  localparam real TPROP_PCB_DATA     = 0.00;  // Delay for data signal during Write operation
  localparam real TPROP_PCB_DATA_RD  = 0.00;  // Delay for data signal during Read operation

  localparam MEMORY_WIDTH = 8;
  localparam NUM_COMP = DQ_WIDTH/MEMORY_WIDTH;
  localparam real CLK_PERIOD = tCK;
  localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
  localparam real PCIECLK_PERIOD = (1000000.0/(2*PCIE_USER_CLK));
  localparam DRAM_DEVICE = "SODIMM";
                         // DRAM_TYPE: "UDIMM", "RDIMM", "COMPS"

   // VT delay change options/settings
  localparam VT_ENABLE                  = "OFF";
                                        // Enable VT delay var's
  localparam VT_RATE                    = CLK_PERIOD/500;
                                        // Size of each VT step
  localparam VT_UPDATE_INTERVAL         = CLK_PERIOD*50;
                                        // Update interval
  localparam VT_MAX                     = CLK_PERIOD/40;
                                        // Maximum VT shift


  function integer STR_TO_INT;
    input [7:0] in;
    begin
      if(in == "8")
        STR_TO_INT = 8;
      else if(in == "4")
        STR_TO_INT = 4;
      else
        STR_TO_INT = 0;
    end
  endfunction

  localparam APP_DATA_WIDTH = PAYLOAD_WIDTH * 4;
  localparam APP_MASK_WIDTH = APP_DATA_WIDTH / 8;
  localparam BURST_LENGTH   = STR_TO_INT(BURST_MODE);
  //**************************************************************************//
  // Wire Declarations
  //**************************************************************************//
  reg app_en;
  wire app_ack;
  reg[31:0] app_instr; 
  wire iq_full;
  wire processing_iseq;
		
  //Data read back Interface
  wire rdback_fifo_empty;
  reg rdback_fifo_rden;
   wire[511:0] rdback_data;
  
  //reg sys_clk;
  reg clk_ref;
  reg phy_rst;
  reg pci_rst_n;

  //wire sys_clk_p;
 // wire sys_clk_n;
  wire clk_ref_p;
  wire clk_ref_n;


  reg [DM_WIDTH-1:0]                 ddr3_dm_sdram_tmp;

  wire sys_rst;

  wire                               error;
  wire                               phy_init_done;
  wire                               ddr3_parity;
  wire                               ddr3_reset_n;
  wire                               sda;
  wire                               scl;

  wire [DQ_WIDTH-1:0]                ddr3_dq_fpga;
  wire [ROW_WIDTH-1:0]               ddr3_addr_fpga;
  wire [BANK_WIDTH-1:0]              ddr3_ba_fpga;
  wire                               ddr3_ras_n_fpga;
  wire                               ddr3_cas_n_fpga;
  wire                               ddr3_we_n_fpga;
  wire [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_cs_n_fpga;
  wire [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_odt_fpga;
  wire [CKE_WIDTH-1:0]               ddr3_cke_fpga;
  wire [DM_WIDTH-1:0]                ddr3_dm_fpga;
  wire [DQS_WIDTH-1:0]               ddr3_dqs_p_fpga;
  wire [DQS_WIDTH-1:0]               ddr3_dqs_n_fpga;
  wire [CK_WIDTH-1:0]                c0_ddr4_ck_t;
  wire [CK_WIDTH-1:0]                c0_ddr4_ck_c;

  wire [DQ_WIDTH-1:0]                ddr3_dq_sdram;
  reg [ROW_WIDTH-1:0]                ddr3_addr_sdram;
  reg [BANK_WIDTH-1:0]               ddr3_ba_sdram;
  reg                                ddr3_ras_n_sdram;
  reg                                ddr3_cas_n_sdram;
  reg                                ddr3_we_n_sdram;
  reg [(CS_WIDTH*nCS_PER_RANK)-1:0]  ddr3_cs_n_sdram;
  reg [(CS_WIDTH*nCS_PER_RANK)-1:0]  ddr3_odt_sdram;
  reg [CKE_WIDTH-1:0]                ddr3_cke_sdram;
  wire [DM_WIDTH-1:0]                ddr3_dm_sdram;
  wire [DQS_WIDTH-1:0]               ddr3_dqs_p_sdram;
  wire [DQS_WIDTH-1:0]               ddr3_dqs_n_sdram;
  reg [CK_WIDTH-1:0]                 ddr3_ck_p_sdram;
  reg [CK_WIDTH-1:0]                 ddr3_ck_n_sdram;

  reg [ROW_WIDTH-1:0]               ddr3_addr_r;
  reg [BANK_WIDTH-1:0]              ddr3_ba_r;
  reg                               ddr3_ras_n_r;
  reg                               ddr3_cas_n_r;
  reg                               ddr3_we_n_r;
  reg [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_cs_n_r;
  reg [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_odt_r;
  reg [CKE_WIDTH-1:0]               ddr3_cke_r;


  wire                               clk;
  wire                               rst;
  wire                               app_sz;
  //wire [ADDR_WIDTH-1:0]              app_addr;
  wire                               app_wdf_wren;
  wire [APP_DATA_WIDTH-1:0]          app_wdf_data;
  wire [APP_MASK_WIDTH-1:0]          app_wdf_mask;
  wire                               app_wdf_end;
  wire                               app_rd_data_end;
  wire                               app_rd_data_valid;
  wire [6:0]                         tg_wr_fifo_counts;
  wire [6:0]                         tg_rd_fifo_counts;
  wire                               tg_rd_en;
  wire [APP_DATA_WIDTH-1:0]          app_rd_data;
  wire [31:0]                        tpt_hdata;
  wire                               t_gen_run_traffic;
  wire [31:0]                        t_gen_start_addr;
  wire [31:0]                        t_gen_end_addr;
  wire [31:0]                        t_gen_cmd_seed;
  wire [31:0]                        t_gen_data_seed;
  wire                               t_gen_load_seed;
  wire [2:0]                         t_gen_addr_mode;
  wire [3:0]                         t_gen_instr_mode;
  wire [1:0]                         t_gen_bl_mode;
  wire [3:0]                         t_gen_data_mode;
  wire                               t_gen_mode_load;
  wire [5:0]                         t_gen_fixed_bl;
  wire [2:0]                         t_gen_fixed_instr;
  wire [31:0]                        t_gen_fixed_addr;
  wire                               manual_clear_error;
  wire                               modify_enable_sel;
  wire [2:0]                         vio_data_mode;
  wire [2:0]                         vio_addr_mode;
  
  //=============DDR4 PORT ============================
  parameter CA_MIRROR                      = "OFF";
  
 //// wire    c0_ddr4_ck_t;
 // wire    c0_ddr4_ck_c;
  wire                 c0_ddr4_reset_n;
  wire  [7:0]          c0_ddr4_dm_dbi_n;
  wire  [63:0]          c0_ddr4_dq;
  wire  [7:0]          c0_ddr4_dqs_c;
  wire  [7:0]          c0_ddr4_dqs_t;
    
  wire  [0:0]           c0_ddr4_cke;
  wire  [0:0]           c0_ddr4_odt;
  wire  [0:0]            c0_ddr4_cs_n;
    
  wire                 c0_ddr4_act_n;
    
  reg  [1:0]           c0_ddr4_ba_sdram[1:0];
  reg  [0:0]           c0_ddr4_bg_sdram[1:0];
    
  reg [ADDR_WIDTH-1:0] DDR4_ADRMOD[RANK_WIDTH-1:0];
  
  wire  [1:0]          c0_ddr4_ba;
  wire  [0:0]    c0_ddr4_bg;
  wire  [16:0]          c0_ddr4_adr;
  
  wire  [0:0]  c0_ddr4_ck_t_int;
  wire  [0:0]  c0_ddr4_ck_c_int;
  
  reg  [16:0]            c0_ddr4_adr_sdram[1:0];
  

  
  reg  [31:0] cmdName;
  localparam MRS                           = 3'b000;
  localparam REF                           = 3'b001;
  localparam PRE                           = 3'b010;
  localparam ACT                           = 3'b011;
  localparam WR                            = 3'b100;
  localparam RD                            = 3'b101;
  localparam ZQC                           = 3'b110;
  localparam NOP                           = 3'b111;
  //===============DDR4==============
  
  
  /*always @(*)
    if (c0_ddr4_cs_n == 4'b1111)
      cmdName = "DSEL";
    else
    if (c0_ddr4_act_n)
      casez (DDR4_ADRMOD[0][16:14])
       MRS:     cmdName = "MRS";
       REF:     cmdName = "REF";
       PRE:     cmdName = "PRE";
       WR:      cmdName = "WR";
       RD:      cmdName = "RD";
       ZQC:     cmdName = "ZQC";
       NOP:     cmdName = "NOP";
      default:  cmdName = "***";
      endcase
    else
      cmdName = "ACT";

   reg wr_en ;
   always@(posedge c0_ddr4_ck_t)begin
     if(!c0_ddr4_reset_n)begin
       wr_en <= #100 1'b0 ;
     end else begin
       if(cmdName == "WR")begin
         wr_en <= #100 1'b1 ;
       end else if (cmdName == "RD")begin
         wr_en <= #100 1'b0 ;
       end
     end
   end */

genvar rnk;
generate
localparam IDX = CS_WIDTH;
for (rnk = 0; rnk < IDX; rnk++) begin:rankup
 always @(*)
    if (c0_ddr4_act_n)
      casez (c0_ddr4_adr_sdram[0][16:14])
      WR, RD: begin
        DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk] & 18'h1C7FF;
      end
      default: begin
        DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk];
      end
      endcase
    else begin
      DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk];
    end
end
endgenerate

  //**************************************************************************//
  // Reset Generation
  //**************************************************************************//
  bit  en_model;
  tri  model_enable = en_model;
  
  initial begin
     //sys_rst = 1'b0;
     //#200
     //sys_rst = 1'b1;
     en_model = 1'b0; 
     #5 en_model = 1'b1;
     //#200;
     //sys_rst = 1'b0;
     //#100;
  end 
 

  //**************************************************************************//
  // Clock generation and reset
  //**************************************************************************//

  initial begin
  //  sys_clk   = 1'b0;
    clk_ref   = 1'b1;
    phy_rst = 1'b0;
    pci_rst_n = 1'b0;
    #120000
      phy_rst = 1'b1;
      pci_rst_n = 1'b1;
  end

   assign sys_rst = RST_ACT_LOW ? phy_rst : ~phy_rst;

  // Generate system clock = twice rate of CLK
 // always
   // sys_clk = #(CLK_PERIOD/2.0) ~sys_clk;

  // Generate IDELAYCTRL reference clock (200MHz)
  always
    clk_ref = #REFCLK_PERIOD ~clk_ref;

  //assign sys_clk_p = sys_clk;
 // assign sys_clk_n = ~sys_clk;

  assign clk_ref_p = clk_ref;
  assign clk_ref_n = ~clk_ref;


  //**************************************************************************//

  always @( * ) begin
    ddr3_ck_p_sdram   <=  #(TPROP_PCB_CTRL) c0_ddr4_ck_t;
    ddr3_ck_n_sdram   <=  #(TPROP_PCB_CTRL) c0_ddr4_ck_c;
    ddr3_addr_sdram   <=  #(TPROP_PCB_CTRL) ddr3_addr_fpga;
    ddr3_ba_sdram     <=  #(TPROP_PCB_CTRL) ddr3_ba_fpga;
    ddr3_ras_n_sdram  <=  #(TPROP_PCB_CTRL) ddr3_ras_n_fpga;
    ddr3_cas_n_sdram  <=  #(TPROP_PCB_CTRL) ddr3_cas_n_fpga;
    ddr3_we_n_sdram   <=  #(TPROP_PCB_CTRL) ddr3_we_n_fpga;
    ddr3_cs_n_sdram   <=  #(TPROP_PCB_CTRL) ddr3_cs_n_fpga;
    ddr3_cke_sdram    <=  #(TPROP_PCB_CTRL) ddr3_cke_fpga;
    ddr3_odt_sdram    <=  #(TPROP_PCB_CTRL) ddr3_odt_fpga;
    ddr3_dm_sdram_tmp <=  #(TPROP_PCB_DATA) ddr3_dm_fpga;//DM signal generation
  end

  assign ddr3_dm_sdram = {DM_WIDTH{1'b0}};

// Controlling the bi-directional BUS
  genvar dqwd;
  generate
    for (dqwd = 1;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g  (TPROP_PCB_DATA),
        .Delay_rd (TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dq
       (
        .A     (ddr3_dq_fpga[dqwd]),
        .B     (ddr3_dq_sdram[dqwd]),
        .reset (phy_rst),
        .phy_init_done (phy_init_done)
       );
     end
      WireDelay #
       (
        .Delay_g  (TPROP_PCB_DATA),
        .Delay_rd (TPROP_PCB_DATA_RD),
        .ERR_INSERT (ECC)
       )
      u_delay_dq_0
       (
        .A     (ddr3_dq_fpga[0]),
        .B     (ddr3_dq_sdram[0]),
        .reset (phy_rst),
        .phy_init_done (phy_init_done)
       );

  endgenerate

  genvar dqswd;
  generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g  (TPROP_DQS),
        .Delay_rd (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dqs_p
       (
        .A     (ddr3_dqs_p_fpga[dqswd]),
        .B     (ddr3_dqs_p_sdram[dqswd]),
        .reset (phy_rst),
        .phy_init_done (phy_init_done)
       );

      WireDelay #
       (
        .Delay_g  (TPROP_DQS),
        .Delay_rd (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dqs_n
       (
        .A     (ddr3_dqs_n_fpga[dqswd]),
        .B     (ddr3_dqs_n_sdram[dqswd]),
        .reset (phy_rst),
        .phy_init_done (phy_init_done)
       );
    end
  endgenerate
  assign sda = 1'b1;
  assign scl = 1'b1;
  
  
  // Instantiate the Unit Under Test (UUT)
	softMC_top #
    (
     .nCK_PER_CLK               (nCK_PER_CLK),
     .tCK                       (tCK),
     .RST_ACT_LOW               (RST_ACT_LOW),
     .REFCLK_FREQ               (REFCLK_FREQ),
     .IODELAY_GRP               (IODELAY_GRP),
     .INPUT_CLK_TYPE            (INPUT_CLK_TYPE),
     .BANK_WIDTH                (BANK_WIDTH),
     .CK_WIDTH                  (CK_WIDTH),
     .CKE_WIDTH                 (CKE_WIDTH),
     .COL_WIDTH                 (COL_WIDTH),
     .nCS_PER_RANK              (nCS_PER_RANK),
     .DQ_WIDTH                  (DQ_WIDTH),
 .DQS_CNT_WIDTH             (DQS_CNT_WIDTH),
     .DQS_WIDTH                 (DQS_WIDTH),
     .ROW_WIDTH                 (ROW_WIDTH),
     .RANK_WIDTH                (RANK_WIDTH),
     .CS_WIDTH                  (CS_WIDTH),
     .BURST_MODE                (BURST_MODE),
     .BM_CNT_WIDTH              (BM_CNT_WIDTH),
     .CLKFBOUT_MULT_F           (CLKFBOUT_MULT_F),
     .DIVCLK_DIVIDE             (DIVCLK_DIVIDE),
     .CLKOUT_DIVIDE             (CLKOUT_DIVIDE),
     .OUTPUT_DRV                (OUTPUT_DRV),
     .REG_CTRL                  (REG_CTRL),
     .RTT_NOM                   (RTT_NOM),
     .RTT_WR                    (RTT_WR),
     .SIM_BYPASS_INIT_CAL       (SIM_BYPASS_INIT_CAL),
     .DEBUG_PORT                (DEBUG_PORT),
     .tPRDI                     (tPRDI),
     .tREFI                     (tREFI),
     .tZQI                      (tZQI),
     .ADDR_CMD_MODE             (ADDR_CMD_MODE),
     .ORDERING                  (ORDERING),
     .STARVE_LIMIT              (STARVE_LIMIT),
     //.ADDR_WIDTH                (ADDR_WIDTH),
     .ECC                       (ECC),
     .ECC_TEST                  (ECC_TEST),
     .TCQ                       (TCQ),
     .DATA_WIDTH                (DATA_WIDTH),
     .PAYLOAD_WIDTH             (PAYLOAD_WIDTH)
     ) uut (
		.phy_clk_p(clk_ref_p), 
		.phy_clk_n(clk_ref_n), 
		.pci_clk_p(clk_ref_p),
		.pci_clk_n(clk_ref_n),
		//.clk_ref_p(clk_ref_p), 
		//.clk_ref_n(clk_ref_n), 
		.phy_rst_n(phy_rst), 
		.pci_rst_n(pci_rst_n), 
		//.sys_rst_l(sys_rst_l),
		//.c0_ddr4_reset_n(1'b1),
		//.c0_ddr4_reset_n(c0_ddr4_reset_n),
		.c0_ddr4_ck_c(c0_ddr4_ck_c_int),  // 0625 c? t?
		.c0_ddr4_ck_t(c0_ddr4_ck_t_int), 
		.c0_ddr4_adr(c0_ddr4_adr), 
		.c0_ddr4_ba(c0_ddr4_ba), // add ba, bg
		.c0_ddr4_bg(c0_ddr4_bg), // add ba, bg
		.c0_ddr4_act_n(c0_ddr4_act_n),
		.c0_ddr4_cs_n(c0_ddr4_cs_n), 
		.c0_ddr4_cke(c0_ddr4_cke), 
		.c0_ddr4_odt(c0_ddr4_odt), 
		.c0_ddr4_reset_n(c0_ddr4_reset_n), 
		//.ddr_parity(), 
		.c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n), 

		.c0_ddr4_dqs_c(c0_ddr4_dqs_c), 
		.c0_ddr4_dqs_t(c0_ddr4_dqs_t), 
		.c0_ddr4_dq(c0_ddr4_dq),
		.c0_init_calib_complete(phy_init_done),
		//.iq_full(iq_full),
		//.processing_iseq(processing_iseq),
		//.sys_clk_p(clk_ref_p),
		//.sys_clk_n(clk_ref_n),
	   // .app_en(app_en),
		//.app_ack(app_ack),
		//.app_instr(app_instr),
		
		.rdback_fifo_rden(rdback_fifo_rden),
		.rdback_data(rdback_data),
		.rdback_fifo_empty(rdback_fifo_empty)
	);
	 
	`ifndef USE_XDMA
	
	initial begin
	   uut.EP.user_clk=1'b0;
	   uut.EP.user_resetn=1'b0;
	   uut.EP.s_axis_c2h_tready_0=1'b1;
	   #10000
       uut.EP.user_resetn=1'b1;
    
    end
    
    always
       uut.EP.user_clk = #(PCIECLK_PERIOD) ~uut.EP.user_clk;
       
    `endif
	//==========================DDR4====================================
	//**************************************************************************//
  // Clock Generation
  //**************************************************************************//

  //initial
  //  sys_clk_i = 1'b0;
  //always
   // sys_clk_i = #(13924/2.0) ~sys_clk_i;

  //assign c0_sys_clk_p = sys_clk_i;
  //assign c0_sys_clk_n = ~sys_clk_i;

  assign c0_ddr4_ck_t = c0_ddr4_ck_t_int[0];
  assign c0_ddr4_ck_c = c0_ddr4_ck_c_int[0];

   always @( * ) begin
     c0_ddr4_adr_sdram[0]   <=  c0_ddr4_adr;
     c0_ddr4_adr_sdram[1]   <=  (CA_MIRROR == "ON") ?
                                       {c0_ddr4_adr[ADDR_WIDTH-1:14],
                                        c0_ddr4_adr[11], c0_ddr4_adr[12],
                                        c0_ddr4_adr[13], c0_ddr4_adr[10:9],
                                        c0_ddr4_adr[7], c0_ddr4_adr[8],
                                        c0_ddr4_adr[5], c0_ddr4_adr[6],
                                        c0_ddr4_adr[3], c0_ddr4_adr[4],
                                        c0_ddr4_adr[2:0]} :
                                        c0_ddr4_adr;
     c0_ddr4_ba_sdram[0]    <=  c0_ddr4_ba;
     c0_ddr4_ba_sdram[1]    <=  (CA_MIRROR == "ON") ?
                                        {c0_ddr4_ba[0],
                                         c0_ddr4_ba[1]} :
                                         c0_ddr4_ba;
     c0_ddr4_bg_sdram[0]    <=  c0_ddr4_bg;
      c0_ddr4_bg_sdram[1]    <=  c0_ddr4_bg;
    end
	
	
	//==========================DDR4====================================
	//===========================================================================
  //                         Memory Model instantiation
  //===========================================================================
	genvar i;
    genvar r;
    genvar s;
	localparam DRAM_WIDTH                    = 16;
	localparam ADDR_WIDTH                    = 17;
	localparam NUM_PHYSICAL_PARTS = (DQ_WIDTH/DRAM_WIDTH) ;
	
	import arch_package::*;
	
	//typedef enum {_2G=2, _4G=4, _8G=8, _16G=16} UTYPE_density;
    parameter UTYPE_density CONFIGURED_DENSITY = _8G;
    //parameter CONFIGURED_DENSITY = 8;
    
    // DDR4 ports 
    /*
    wire    c0_ddr4_ck_t;
    wire    c0_ddr4_ck_c;
    wire                 c0_ddr4_reset_n;
    wire  [7:0]          c0_ddr4_dm_dbi_n;
    wire  [63:0]          c0_ddr4_dq;
    wire  [7:0]          c0_ddr4_dqs_c;
    wire  [7:0]          c0_ddr4_dqs_t;
    
    wire  [0:0]           c0_ddr4_cke;
    wire  [0:0]           c0_ddr4_odt;
    wire  [0:0]            c0_ddr4_cs_n;
    
    wire                 c0_ddr4_act_n;
    
    reg  [1:0]           c0_ddr4_ba_sdram[1:0];
    reg  [0:0]           c0_ddr4_bg_sdram[1:0];
    
    reg [ADDR_WIDTH-1:0] DDR4_ADRMOD[RANK_WIDTH-1:0];
    */
	
	generate
	begin: mem_model_x16
    if (DQ_WIDTH/16) begin: mem
    
          DDR4_if #(.CONFIGURED_DQ_BITS (16)) iDDR4[0:(RANK_WIDTH*NUM_PHYSICAL_PARTS)-1]();
    
            for (r = 0; r < RANK_WIDTH; r++) begin:memModels_Ri2
              for (i = 0; i < NUM_PHYSICAL_PARTS; i++) begin:memModel2
                ddr4_model  #
                (
                 .CONFIGURED_DQ_BITS (16),
                 .CONFIGURED_DENSITY (CONFIGURED_DENSITY)
                 )  ddr4_model(
                    .model_enable (model_enable),
                    .iDDR4        (iDDR4[(r*NUM_PHYSICAL_PARTS)+i])
                );
              end
            end
    
            for (r = 0; r < RANK_WIDTH; r++) begin:tranDQ3
              for (i = 0; i < NUM_PHYSICAL_PARTS; i++) begin:tranDQ13
                for (s = 0; s < 16; s++) begin:tranDQ2
                  `ifdef XILINX_SIMULATOR
                  short bidiDQ(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQ[s], c0_ddr4_dq[s+i*16]);
                  `else
                  tran bidiDQ(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQ[s], c0_ddr4_dq[s+i*16]);
                  `endif
                end
              end
            end
    
            for (r = 0; r < RANK_WIDTH; r++) begin:tranDQS3
              for (i = 0; i < NUM_PHYSICAL_PARTS; i++) begin:tranDQS13
              `ifdef XILINX_SIMULATOR
                short bidiDQS0(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_t[0], c0_ddr4_dqs_t[(2*i)]);
                short bidiDQS0_(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_c[0], c0_ddr4_dqs_c[(2*i)]);
                short bidiDM0(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DM_n[0], c0_ddr4_dm_dbi_n[(2*i)]);
                short bidiDQS1(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_t[1], c0_ddr4_dqs_t[((2*i)+1)]);
                short bidiDQS1_(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_c[1], c0_ddr4_dqs_c[((2*i)+1)]);
                short bidiDM1(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DM_n[1], c0_ddr4_dm_dbi_n[((2*i)+1)]);
    
              `else
                tran bidiDQS0(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_t[0], c0_ddr4_dqs_t[(2*i)]);
                tran bidiDQS0_(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_c[0], c0_ddr4_dqs_c[(2*i)]);
                tran bidiDM0(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DM_n[0], c0_ddr4_dm_dbi_n[(2*i)]);
                tran bidiDQS1(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_t[1], c0_ddr4_dqs_t[((2*i)+1)]);
                tran bidiDQS1_(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DQS_c[1], c0_ddr4_dqs_c[((2*i)+1)]);
                tran bidiDM1(iDDR4[(r*NUM_PHYSICAL_PARTS)+i].DM_n[1], c0_ddr4_dm_dbi_n[((2*i)+1)]);
              `endif
            end
          end
    
           for (r = 0; r < RANK_WIDTH; r++) begin:tranADCTL_RANKS
             for (i = 0; i < NUM_PHYSICAL_PARTS; i++) begin:tranADCTL
    
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].BG        = c0_ddr4_bg_sdram[r];
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].BA        = c0_ddr4_ba_sdram[r];
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].ADDR_17 = (ADDR_WIDTH == 18) ? DDR4_ADRMOD[r][ADDR_WIDTH-1] : 1'b0;
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].ADDR      = DDR4_ADRMOD[r][13:0];
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CS_n = c0_ddr4_cs_n[r];
    
             end
           end
    
        for (r = 0; r < RANK_WIDTH; r++) begin:tranADCTL_RANKS1
          for (i = 0; i < NUM_PHYSICAL_PARTS; i++) begin:tranADCTL1
             // assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CK = {c0_ddr4_ck_t, c0_ddr4_ck_t};
               assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CK[0] = c0_ddr4_ck_c;
                assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CK[1]=c0_ddr4_ck_t;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].ACT_n     = c0_ddr4_act_n;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].RAS_n_A16 = DDR4_ADRMOD[r][16];
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CAS_n_A15 = DDR4_ADRMOD[r][15];
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].WE_n_A14  = DDR4_ADRMOD[r][14];
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].CKE       = c0_ddr4_cke[r];
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].ODT       = c0_ddr4_odt[r];
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].PARITY  = 1'b0;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].TEN     = 1'b0;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].ZQ      = 1'b1;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].PWR     = 1'b1;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].VREF_CA = 1'b1;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].VREF_DQ = 1'b1;
              assign iDDR4[(r*NUM_PHYSICAL_PARTS)+ i].RESET_n = c0_ddr4_reset_n;
              end
            end
          end
    
          if (DQ_WIDTH%16) begin: mem_extra_bits
           // DDR4 X16 dual rank is not supported
            DDR4_if #(.CONFIGURED_DQ_BITS (16)) iDDR4[(DQ_WIDTH/DRAM_WIDTH):(DQ_WIDTH/DRAM_WIDTH)]();
    
            ddr4_model  #
              (
               .CONFIGURED_DQ_BITS (16),
               .CONFIGURED_DENSITY (CONFIGURED_DENSITY)
               )  ddr4_model(
                .model_enable (model_enable),
                .iDDR4        (iDDR4[(DQ_WIDTH/DRAM_WIDTH)])
            );
    
            for (i = (DQ_WIDTH/DRAM_WIDTH)*16; i < DQ_WIDTH; i=i+1) begin:tranDQ
              `ifdef XILINX_SIMULATOR
              short bidiDQ(iDDR4[i/16].DQ[i%16], c0_ddr4_dq[i]);
              short bidiDQ_msb(iDDR4[i/16].DQ[(i%16)+8], c0_ddr4_dq[i]);
              `else
              tran bidiDQ(iDDR4[i/16].DQ[i%16], c0_ddr4_dq[i]);
              tran bidiDQ_msb(iDDR4[i/16].DQ[(i%16)+8], c0_ddr4_dq[i]);
              `endif
            end
    
            `ifdef XILINX_SIMULATOR
            short bidiDQS0(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_t[0], c0_ddr4_dqs_t[DQS_WIDTH-1]);
            short bidiDQS0_(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_c[0], c0_ddr4_dqs_c[DQS_WIDTH-1]);
            short bidiDM0(iDDR4[DQ_WIDTH/DRAM_WIDTH].DM_n[0], c0_ddr4_dm_dbi_n[DM_WIDTH-1]);
            short bidiDQS1(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_t[1], c0_ddr4_dqs_t[DQS_WIDTH-1]);
            short bidiDQS1_(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_c[1], c0_ddr4_dqs_c[DQS_WIDTH-1]);
            short bidiDM1(iDDR4[DQ_WIDTH/DRAM_WIDTH].DM_n[1], c0_ddr4_dm_dbi_n[DM_WIDTH-1]);
            `else
            tran bidiDQS0(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_t[0], c0_ddr4_dqs_t[DQS_WIDTH-1]);
            tran bidiDQS0_(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_c[0], c0_ddr4_dqs_c[DQS_WIDTH-1]);
            tran bidiDM0(iDDR4[DQ_WIDTH/DRAM_WIDTH].DM_n[0], c0_ddr4_dm_dbi_n[DM_WIDTH-1]);
            tran bidiDQS1(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_t[1], c0_ddr4_dqs_t[DQS_WIDTH-1]);
            tran bidiDQS1_(iDDR4[DQ_WIDTH/DRAM_WIDTH].DQS_c[1], c0_ddr4_dqs_c[DQS_WIDTH-1]);
            tran bidiDM1(iDDR4[DQ_WIDTH/DRAM_WIDTH].DM_n[1], c0_ddr4_dm_dbi_n[DM_WIDTH-1]);
            `endif
    
           // assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CK = {c0_ddr4_ck_t, c0_ddr4_ck_t};
            
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CK[0] = c0_ddr4_ck_c;
            
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CK[1] = c0_ddr4_ck_t;
            
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].ACT_n = c0_ddr4_act_n;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].RAS_n_A16 = DDR4_ADRMOD[0][16];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CAS_n_A15 = DDR4_ADRMOD[0][15];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].WE_n_A14 = DDR4_ADRMOD[0][14];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CKE = c0_ddr4_cke[0];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].ODT = c0_ddr4_odt[0];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].BG = c0_ddr4_bg_sdram[0];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].BA = c0_ddr4_ba_sdram[0];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].ADDR_17 = (ADDR_WIDTH == 18) ? DDR4_ADRMOD[0][ADDR_WIDTH-1] : 1'b0;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].ADDR = DDR4_ADRMOD[0][13:0];
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].RESET_n = c0_ddr4_reset_n;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].TEN     = 1'b0;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].ZQ      = 1'b1;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].PWR     = 1'b1;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].VREF_CA = 1'b1;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].VREF_DQ = 1'b1;
            assign iDDR4[DQ_WIDTH/DRAM_WIDTH].CS_n = c0_ddr4_cs_n[0];
          end
        end
      endgenerate
	//***************************************************************************
  // Reporting the test case status
  //***************************************************************************
  localparam APP_CLK_PERIOD = tCK * nCK_PER_CLK;
  
  
  initial
  begin : Logging
		 uut.EP.m_axis_h2c_tdata_0= 32'b00000000000000000000000000000000 ;
		 uut.EP.m_axis_h2c_tvalid_0=1'b0;
		 uut.EP.s_axis_c2h_tready_0=1'b1;
		//rdback_fifo_rden = 0;
        begin : calibration_done
           wait (phy_init_done);
           $display("Calibration Done");
			  
         //  #1000000;
			  
			  
	 
	  #(PCIECLK_PERIOD*1000);
	  //read
	  #PCIECLK_PERIOD;
	    //app_en = 1;
		//app_instr = 32'b00010000000000000000000000000010; //busdir

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0=1'b1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000100000000000000000000 ; // precharge  

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000110000000000000000000 ; //act

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111;  //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b11111111001000001101000000000000  ; //write

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		
		


		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001000  ; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000100000000000000000000  ; //precharge

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111  ; //wait

		//#PCIECLK_PERIOD;
		//app_en = 1;
		//uut.EP.m_axis_h2c_tdata_0 = 32'b00000000000000000000000000000000;  //end
		
		//#PCIECLK_PERIOD;
		//app_en = 1;
		//uut.EP.m_axis_h2c_tdata_0 = 32'b00010000000000000000000000000000;
		#PCIECLK_PERIOD;
		
		
        // read
		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000100000000000000000000 ; //pre

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111 ; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000110000000000000000000 ; //act

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111 ; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001001010000001000000000000 ; //read

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		
		
		/////////
		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001001010000001000000000000 ; //read

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		
		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001001010000001000000000000 ; //read

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		
		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001001010000001000000000000 ; //read

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		
		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001001010000001000000000000 ; //read

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0= 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001110 ; //wait
		///////////
		

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001000 ; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b10000001000100000000000000000000 ; //pre

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b01000000000000000000000000001111; //wait

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 1;
		uut.EP.m_axis_h2c_tdata_0 = 32'b00000000000000000000000000000000; //end
		

		#PCIECLK_PERIOD;
		uut.EP.m_axis_h2c_tvalid_0 = 0;
		
		//rdback_fifo_rden = 1;
        end
  end
 /* initial
  begin : Logging
		app_en = 0;
		app_instr= 32'b10000001000100000000000000000000 ;
		rdback_fifo_rden = 0;
        begin : calibration_done
           wait (phy_init_done);
           $display("Calibration Done");
			  
           #1000000;
			  
			  
	  app_en = 0;
	  #(APP_CLK_PERIOD*1000);
	  //read
	  #APP_CLK_PERIOD;
	    //app_en = 1;
		//app_instr = 32'b00010000000000000000000000000010; //busdir

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000100000000000000000000 ; // precharge

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000110000000000000000000 ; //act

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111;  //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b11111111001000001101000000000000  ; //write

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		
		


		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001000  ; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000100000000000000000000  ; //precharge

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111  ; //wait

		//#APP_CLK_PERIOD;
		//app_en = 1;
		//app_instr = 32'b00000000000000000000000000000000;  //end
		
		//#APP_CLK_PERIOD;
		//app_en = 1;
		//app_instr = 32'b00010000000000000000000000000000;
		#APP_CLK_PERIOD;
		
		
        // read
		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000100000000000000000000 ; //pre

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111 ; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000110000000000000000000 ; //act

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111 ; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001001010000001000000000000 ; //read

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		
		
		/////////
		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001001010000001000000000000 ; //read

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		
		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001001010000001000000000000 ; //read

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		
		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001001010000001000000000000 ; //read

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		
		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001001010000001000000000000 ; //read

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001110 ; //wait
		///////////
		

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001000 ; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b10000001000100000000000000000000 ; //pre

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b01000000000000000000000000001111; //wait

		#APP_CLK_PERIOD;
		app_en = 1;
		app_instr = 32'b00000000000000000000000000000000; //end
		

		#APP_CLK_PERIOD;
		app_en = 0;
		
		//rdback_fifo_rden = 1;
        end
  end*/
      
endmodule

