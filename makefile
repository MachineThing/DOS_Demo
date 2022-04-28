# Commands
RM=rm -r
FIND=find -name
# Compilers/Interpreters
CC=bcc
AS=nasm
LD=ld86
DB=dosbox-x
# Flags
CCFLAGS=-ansi -W -0
ASFLAGS=-f as86
LDFLAGS=-0 -d -T0x100
DBFLAGS=-conf dosbox.conf -fastlaunch
# Paths
SRC=./src
CCFILES=$(shell $(FIND) "*.c")
ASFILES=$(shell $(FIND) "*.asm")
OBJ=$(patsubst %.c,%.o,$(CCFILES)) $(patsubst %.asm,%.o,$(ASFILES))
BUILD=build
BIN=$(BUILD)/demo.com

.SUFFIXES: .o .c .asm
.PHONY: all clean run

all: $(BIN) $(BUILD)

$(BIN): $(OBJ) $(BUILD)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

$(BUILD):
	cp -r res $(BUILD)

.c.o:
	$(CC) $(CCFLAGS) -c $< -o $*.o

.asm.o:
	$(AS) $(ASFLAGS) $< -o $*.o

clean:
	$(RM) $(shell $(FIND) "*.o") $(BUILD)

run: $(BIN)
	$(DB) $^ $(DBFLAGS)

debug: $(BIN)
	$(DB) $^ $(DBFLAGS) -break-start
