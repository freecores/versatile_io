`include "include/versatile_io_defines.v"
`ifdef UART0
`include "uart16550_ip.v"
`endif
module versatile_io (
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    input [3:0] wbs_sel_i,
    input wbs_we_i, wbs_stb_i, wbs_cyc_i,
    output [31:0] wbs_dat_o,
    output wbs_ack_o;
`ifdef B4
    output wbs_stall_o,
`endif
`include "versatile_io_module.v"
`ifdef UART0
    output uart0_irq,
`endif
    input wbs_clk, wbs_rst,
    input clk, rst
);

function [7:0] tobyte;
input [3:0] sel_i;
input [31:0] dat_i;
begin
    tobyte = ({8{sel_i[3]}} & dat_i[31:24]) | ({8{sel_i[2]}} & dat_i[23:16]) | ({8{sel_i[1]}} & dat_i[15:8]) | ({8{sel_i[0]}} & dat_i[7:0]);
endfunction

function [31:0] toword;
input [7:0] dat_i;
begin
    toword = {4{dat_i}};
endfunction

function [31:0] mask;
input [31:0] dat_i;
input sel;
begin
    mask = {32{sel}} & dat_i;
end

function cs;
input [31:0] adr;
input [31:0] mem_map;
input [4:0] mem_map_hi;
input [4:0] mem_map_lo;
begin
    cs = adr[mem_map_hi:mem_map_lo] == mem_map[mem_map_hi:mem_map_lo];
endfunction

`ifdef UART0
wire uart0_cs = cs( wbs_adr_i, `UART0_BASE, `UART0_MEM_MAP_HI, `UART0_MEM_MAP_LO);
wire [7:0] uart0_temp;
wire uart0_ack_o;
uart_top uart0	(
    .wb_clk_i(wbs_clk), wb_rst_i(wbs_rst), 	
    // Wishbone signals
    .wb_adr_i(wbs_adr_i[2:0]), .wb_dat_i(tobyte(wbs_sel_i,wbs_dat_i)), .wb_dat_o(uart0_temp), .wb_we_i(wbs_we_i), .wb_stb_i(wbs_stb_i), .wb_cyc_i(wbs_cyc_i & uart0_cs), .wb_ack_o(uart0_ack_o), .wb_sel_i(4'b0),
    .int_o(uart0_irq), // interrupt request
    // UART	signals
    // serial input/output
    .stx_pad_o(uart0_tx_pad_i), .srx_pad_i(uart0_rx_pad_i),
    // modem signals
    .rts_pad_o(), .cts_pad_i(1'b0), .dtr_pad_o(), .dsr_pad_i(1'b0), .ri_pad_i(1'b0), .dcd_pad_i(1'b0) );
assign uart0_dat_o = mask( toword(uart0_temp), uart0_ack_o);
`else
assign uart0_dat_o = 32'h0;
assign uart0_ack_o = 1'b0;
`endif

assign wbs_dat_o = uart0_dat_o;
assign wbs_ack_o = uart0_ack_o;
`ifdef WB4
assign wbs_stall_o = 1'b0;
`endif

endmodule