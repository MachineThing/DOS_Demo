# DOS Demo

A (pretty short) 8086 demo made with x86 assembly

Minimum requirements:
- 8086/286 CPU (Recommended to be atleast 8 MHz)
- A VGA card
- DOS 2+

This demo is a small demo that displays an image and "fades it out" and then displays a text file at the end.

## Building

To build this you will need these tools:
- dev86
- nasm
- Python 3 (For SIF file generation)
- dosbox (I recommend dosbox-x)
- GNU make (usually supplied by `build-essential` by most if not all Debian based distros)
Optionally you will need `mkfs` (which should be installed on UNIX based systems) to make 1.44MB floppy images
