config:
	make -C include/ config

ip:
	make -C uart16550/ ip
	vppreproc --noline --noblank -Iuart16550 top/ip.v | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' | cat - top/versatile_io_top.v > versatile_io.v
	vppreproc --simple -Iinclude top/versatile_io_module.v > versatile_io_module.v
	vppreproc --simple -Iinclude top/versatile_io_wires.v > versatile_io_wires.v
	vppreproc --simple -Iinclude top/versatile_io_module_inst > versatile_io_module_inst.v

clean:
	make -C uart16550/ clean
	rm versatile_io_ip.v versatile_io_module.v versatile_io_module_inst.v versatile_io_wires.v
