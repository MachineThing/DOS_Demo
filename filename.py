#! /bin/python3
import sys
import os.path

for line in sys.stdin:
    # Get pipe input
   pipe_raw = line[:-1]
   # Format it
   pipe_dir = os.path.dirname(pipe_raw)
   pipe_in = os.path.basename(pipe_raw.upper())
   # Check if it's valid
   pipe_chk = pipe_in.split('.')
   try:
       assert len(pipe_chk[0]) <= 8, "Bad filename\n"
       assert len(pipe_chk[1]) <= 3, "Bad file extension\n"
   except AssertionError as err:
       sys.stderr.write(str(err))
   except IndexError:
       sys.stderr.write("No file extension\n")
   else:
       sys.stdout.write(f"{os.path.join(pipe_dir, pipe_in)}\n")
   sys.stderr.flush()
   sys.stdout.flush()
