`include "versatile_io_defines.v"
`ifdef UART0
    input uart0_rx_pad_i,
    output uart0_tx_pad_i,
`endif
`ifdef UART1
    input uart1_rx_pad_i,
    output uart1_tx_pad_i,
`endif
