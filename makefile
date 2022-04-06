# Commands
RM=rm -r
FIND=find -name
# Compilers/Interpreters
CC=bcc
AS=nasm
LD=ld86
# Flags
CCFLAGS=-ansi -W -0
ASFLAGS=
LDFLAGS=-0 -d -s -T0x100
# Paths
SRC=./src
CCFILES=$(shell $(FIND) "*.c")
ASFILES=$(shell $(FIND) "*.asm")
OBJ=$(patsubst %.c,%.o,$(CCFILES)) $(patsubst %.asm,%.o,$(ASFILES))
BIN=demo.com

.SUFFIXES: .o .c .asm
.PHONY: all clean run

all: $(BIN)

$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) $^ -o $@

.c.o:
	$(CC) $(CCFLAGS) -c $< -o $*.o

.asm.o:
	$(AS) -f as86 $(ASFLAGS) $< -o $*.o

clean:
	$(RM) $(shell $(FIND) "*.o") $(KERN) $(KERNOBJ) $(BOOT) $(BIN)

run: $(BIN)
	dosbox-x $(BIN) -conf dosbox.conf
