int coord = 0;

char splash_file[17158];

int main() {
  mode_set(0x13);

  file("SPLASH.BMP\0", 17158, splash_file);

  if (splash_file[0] == 'B' && splash_file[1] == 'M') {
    plot_pixel(10, 10, 14);
  }

  while (1==1) {}
  mode_set(0x03);

  return 0;
}
