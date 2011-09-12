config:
	make -C include/ config

ip:
	make -C uart16550/ ip
	vppreproc --simple -Iinclude -Iuart16550 top/versatile_io_top.v > versatile_io_ip.v
	vppreproc --simple -Iinclude include/versatile_io_module.v > versatile_io_module.v
	vppreproc --simple -Iinclude include/versatile_io_wires.v > versatile_io_wires.v
	vppreproc --simple -Iinclude include/versatile_io_module_inst > versatile_io_module_inst.v

clean:
	make -C uart16550/ clean
	rm versatile_io_ip.v versatile_io_module.v versatile_io_module_inst.v versatile_io_wires.v
