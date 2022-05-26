// Variables
// Strings
char err_splash[22] = "Non-vaild SIF file\r\n\0";
char ending_str[11] = "See ya!\r\n\0";

// File
char file_buff[10];
int file_handle;

// Splash stuff
int splash_x;
int splash_y;
char splash_c;

int color_i;
int pixel_x;
int pixel_y;

// Code
int main() {
  clock_init(); // Initialize clock
  // Go to VGA (13h) mode
  mode_x();

  // Open file and make sure it's a vaild SIF (Simple Image Format) file
  file_handle = fopen("SPLASH.SIF\0");
  fread(file_handle, 8, file_buff);

  if (file_buff[0] == 'S' && file_buff[1] == 'I' && file_buff[2] == 'F') {
    splash_x = file_buff[3] + (file_buff[4] << 8);
    splash_y = file_buff[5] + (file_buff[6] << 8);
    splash_c = file_buff[7];

    // TODO: Set palette
    for (color_i = 0; color_i < splash_c; color_i++) {
      // Get RGB values and set a DAC register to that
      fread(file_handle, 3, file_buff);
      set_dac(color_i, (char)file_buff[0], (char)file_buff[1], (char)file_buff[2]);
    }

    for (pixel_y = 0; pixel_y < splash_y; pixel_y++) {
      for (pixel_x = 0; pixel_x < splash_x; pixel_x++) {
        // Read a byte from the file and plot it to the screen
        fread(file_handle, 1, file_buff);
        plot_pixel(pixel_x, pixel_y, file_buff[0]);
      }
    }

  } else {
    // Close file and go back to text mode
    fclose(file_handle);
    mode_text();
    puts(err_splash);
    return 1;
  }

  fclose(file_handle);
  sleep(91); // 18.2 * 5 seconds = 91
  for (color_i = 0; color_i < splash_c; color_i++) {
    // Set DAC registers to 0
    set_dac(color_i, 0, 0, 0);
    sleep(1);
  }
  sleep(17);

  mode_text();
  file_handle = fopen("CREDIT.TXT\0");
  file_buff[0] = 1; // Just in case
  while (file_buff[0] != 0) {
    sleep(1);
    fread(file_handle, 1, file_buff);
    file_buff[1] = 0;
    puts(file_buff);
  }
  sleep(18);
  puts(ending_str);

  return 0;
}
