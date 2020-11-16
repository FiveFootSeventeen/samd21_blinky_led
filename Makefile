LDSCRIPT= lib/CMSIS-Atmel/samd21/source/as_gcc/samd21e18a_flash.ld
BOOTUP= lib/CMSIS-Atmel/samd21/source/as_gcc/startup_samd21.o lib/CMSIS-Atmel/samd21/source/system_samd21.o
MCUTYPE=__SAMD21E18A__

TEST_FILE= TestCode.c

OBJS=$(BOOTUP) $(TEST_FILE:.c=.o)

# Tools
CC=arm-none-eabi-gcc
LD=arm-none-eabi-gcc
AR=arm-none-eabi-ar
AS=arm-none-eabi-as

ELF=$(TEST_FILE:.c=.elf)

LDFLAGS+= -T$(LDSCRIPT) -L . -mthumb -mcpu=cortex-m0 -Wl,--gc-sections --specs=nosys.specs 
CFLAGS+= -mcpu=cortex-m0 -mthumb -g
CFLAGS+= -Ilib/CMSIS-Atmel/samd21/include/instance -Ilib/CMSIS-Atmel/samd21/include/
CFLAGS+= -Ilib/CMSIS/Include -Ilib/CMSIS-Atmel
CFLAGS+= -D$(MCUTYPE)

$(ELF):         $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

# compile and generate dependency info
%.o:    %.c
	$(CC) -c $(CFLAGS) $< -o $@
	$(CC) -MM $(CFLAGS) $< > $*.d

%.o:    %.s
	$(AS) $< -o $@

clean:
	rm -f $(TEST_FILE:.c=.o) $(OBJS:.o=.d) $(ELF)

# pull in dependencies
-include        $(OBJS:.o=.d)
