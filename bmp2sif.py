#! /bin/python3

from PIL import Image
import struct
import sys

arg_in = sys.argv[1]
arg_out = sys.argv[2]

width = 0
height = 0
avail_colors = 0
colors = []
pixels = []

with Image.open(arg_in) as org_im:
    im = org_im.convert('RGB')
    width = im.width
    height = im.height

    for y in range(height):
        for x in range(width):
            r, g, b = im.getpixel((x, y))
            colval = (r>>2, g>>2, b>>2) # 6-bit VGA
            if colval not in colors:
                avail_colors = avail_colors + 1
                colors.append(colval)
            for color in range(len(colors)):
                if colval == colors[color]:
                    pixels.append(color)

failed = False

if width > 2**16-1:
    sys.stderr.write("Width too large\n")
    failed = True

if height > 2**16-1:
    sys.stderr.write("Height too large\n")
    failed = True

if avail_colors > 2**8-1:
    sys.stderr.write("Over 255 available colors\n")
    failed = True

if failed == True:
    sys.stderr.write("Failed\n")
    sys.stderr.flush()
    exit(1)

with open(arg_out, 'wb') as file:
    file.write("SIF".encode("utf-8"))
    file.write(struct.pack('H', width))
    file.write(struct.pack('H', height))
    file.write(struct.pack('B', avail_colors))
    for color in colors:
        for byte in color:
            file.write(struct.pack('B', byte))
    for pixel in pixels:
        file.write(struct.pack('B', pixel))
