`include "versatile_io_defines.v"
wire [31:0] wbs_vio_dat_i;
wire [31:0] wbs_vio_adr_i;
wire  [3:0] wbs_vio_sel_i;
wire wbs_vio_we_i, wbs_vio_stb_i, wbs_vio_cyc_i;
wire [31:0] wbs_vio_dat_o;
wire wbs_vio_ack_o, wbs_vio_err_o;
`ifdef B4
wire wbs_vio_stall_o;
`endif
`ifdef UART0
wire vio_uart0_irq;
`endif
`ifdef UART1
wire vio_uart1_irq;
`endif
