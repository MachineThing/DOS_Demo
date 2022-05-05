int coord = 0;

char credit_file[144];

int main() {
  /*mode_set(0x13);

  while (coord < 200) {
    plot_pixel(coord, coord, 12);
    coord++;
  }

  plot_pixel(10, 10, 14);
  plot_pixel(15, 10, 14);
  plot_pixel(10, 11, 14);
  plot_pixel(15, 11, 14);
  plot_pixel(10, 13, 14);
  plot_pixel(15, 13, 14);
  plot_pixel(10, 14, 14);
  plot_pixel(15, 14, 14);
  plot_pixel(11, 15, 14);
  plot_pixel(12, 15, 14);
  plot_pixel(13, 15, 14);
  plot_pixel(14, 15, 14);
  while (1==1) {}*/

  mode_set(0x03);
  file("CREDIT.TXT\0", 144, credit_file);
  puts(credit_file);
  return 0;
}
