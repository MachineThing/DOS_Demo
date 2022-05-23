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
BUILD=build
COPYCMD=echo $$i | ./filename.py
BUILDFILES=$(patsubst $(RES)/%,$(BUILD)/%,$(shell for i in $(RESFILES); do $(COPYCMD); done))
BIN=$(BUILD)/DEMO.COM
# Floppy
FLP=floppy.img

.SUFFIXES: .o .c .asm
.PHONY: all clean run debug floppy

all: $(BIN)

$(BIN): $(OBJ) $(BUILD)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

$(BUILD):
	mkdir $(BUILD)
	cp res/credit.txt $(BUILD)/CREDIT.TXT
	echo -ne "\0" >> $(BUILD)/CREDIT.TXT
	./bmp2sif.py res/splash.bmp $(BUILD)/SPLASH.SIF

.c.o:
	$(CC) $(CCFLAGS) -c $< -o $@

.asm.o:
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) $(shell find -name "*.o") $(BUILD) $(FLP)

run: $(BIN)
	$(DB) $^ $(DBFLAGS)

debug: $(BIN)
	$(DB) $^ $(DBFLAGS) -break-start

floppy: $(BIN)
	rm -f $(FLP)
	mkfs.msdos -C $(FLP) 1440 -n DOS_DEMO
	mkdir -p flp
	sudo mount -o loop $(FLP) flp
	sudo cp $(BUILD)/* flp/.
	sudo cp LICENSE.md flp/LICENSE.MD
	sudo cp README.md flp/README.MD
	date +"*This floppy image was built on %A, %B %d %Y*" | sudo tee -a flp/README.MD
	sudo umount flp -f
	sudo rm -rf flp
