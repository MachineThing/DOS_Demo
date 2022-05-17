int coord = 0;

char splash_file[16773];
char err_splash[22] = "Non-vaild SIF file\r\n\0";

int splash_x;
int splash_y;
char splash_c;

int color_i;
int pixel_x;
int pixel_y;

int main() {
  mode_set(0x13);

  file("SPLASH.SIF\0", 16773, splash_file);

  if (splash_file[0] == 'S' && splash_file[1] == 'I' && splash_file[2] == 'F') {
    splash_x = splash_file[3] + (splash_file[4] << 8);
    splash_y = splash_file[5] + (splash_file[6] << 8);
    splash_c = splash_file[7];

    // TODO: Set palette
    for (color_i = 0; color_i < splash_c; color_i++) {
      set_dac(color_i, (char)splash_file[8+color_i*3], (char)splash_file[9+color_i*3], (char)splash_file[10+color_i*3]);
    }

    for (pixel_y = 0; pixel_y < splash_y; pixel_y++) {
      for (pixel_x = 0; pixel_x < splash_x; pixel_x++) {
        plot_pixel(pixel_x, pixel_y, splash_file[(8+splash_c*3)+pixel_y*splash_x+pixel_x]);
      }
    }

  } else {
    mode_set(0x03);
    puts(err_splash);
    return 1;
  }

  while (1==1) {}
  mode_set(0x03);

  return 0;
}
