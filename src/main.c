int coord = 0;

char file_buff[10];
int file_handle;
char err_splash[22] = "Non-vaild SIF file\r\n\0";

int splash_x;
int splash_y;
char splash_c;

int color_i;
int pixel_x;
int pixel_y;

int main() {
  mode_set(0x13);

  file_handle = fopen("SPLASH.SIF\0");
  fread(file_handle, 8, file_buff);

  if (file_buff[0] == 'S' && file_buff[1] == 'I' && file_buff[2] == 'F') {
    splash_x = file_buff[3] + (file_buff[4] << 8);
    splash_y = file_buff[5] + (file_buff[6] << 8);
    splash_c = file_buff[7];

    // TODO: Set palette
    for (color_i = 0; color_i < splash_c; color_i++) {
      fread(file_handle, 3, file_buff);
      set_dac(color_i, (char)file_buff[0], (char)file_buff[1], (char)file_buff[2]);
    }

    for (pixel_y = 0; pixel_y < splash_y; pixel_y++) {
      for (pixel_x = 0; pixel_x < splash_x; pixel_x++) {
        fread(file_handle, 1, file_buff);
        plot_pixel(pixel_x, pixel_y, file_buff[0]);
      }
    }

  } else {
    mode_set(0x03);
    puts(err_splash);
    return 1;
  }

  fclose(file_handle);
  while (1==1) {}
  mode_set(0x03);

  return 0;
}
