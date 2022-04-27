int main() {
  int coord = 0;

  mode_x();
  while (coord < 10) {
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
  while (1==1) {
    /* code */
  }
  mode_text();
  return 0;
}
