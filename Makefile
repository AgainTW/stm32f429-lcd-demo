all:
	$(MAKE) -C build all

clean:
	$(MAKE) -C build clean

flash: build/stm32f429_lcd2.bin
	openocd \
		-f interface/stlink-v2.cfg \
		-f target/stm32f4x.cfg \
		-c "init" \
		-c "reset init" \
		-c "stm32f2x unlock 0" \
		-c "flash probe 0" \
		-c "flash info 0" \
		-c "flash write_image erase build/stm32f429_lcd2.bin 0x8000000" \
		-c "reset run" -c shutdown || \
	st-flash write build/stm32f429_lcd2.bin 0x8000000
