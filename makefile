# Commands
RM=rm -r
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
CCFILES=$(shell find -name "*.c")
ASFILES=$(shell find -name "*.asm")
OBJ=$(patsubst %.c,%.o,$(CCFILES)) $(patsubst %.asm,%.o,$(ASFILES))
RES=res
RESFILES=$(shell find $(RES)/ -type f)
BUILD=build
COPYCMD=echo $$i | ./filename.py
BUILDFILES=$(patsubst $(RES)/%,$(BUILD)/%,$(shell for i in $(RESFILES); do $(COPYCMD); done))
BIN=$(BUILD)/DEMO.COM

.SUFFIXES: .o .c .asm
.PHONY: all clean run

all: $(BIN)

$(BIN): $(OBJ) $(BUILD)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

$(BUILD):
	# I wish there is a better way to do this (there is probably a way through but makefiles are a pain)
	mkdir $(BUILD)
	for i in $(RESFILES); do cp $$i build/$$(basename $$i | ./filename.py); done
	./bmp2sif.py img/splash.bmp $(BUILD)/SPLASH.SIF
	./bmp2sif.py img/calibrte.bmp $(BUILD)/CALIBRTE.SIF

.c.o:
	$(CC) $(CCFLAGS) -c $< -o $@

.asm.o:
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) $(shell find -name "*.o") $(BUILD)

run: $(BIN)
	$(DB) $^ $(DBFLAGS)

debug: $(BIN)
	$(DB) $^ $(DBFLAGS) -break-start
