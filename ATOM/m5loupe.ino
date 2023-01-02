#include <M5Atom.h>

// orientation of your M5ATOM Matrix
#define ORIENTATION_M5ATOM USB_C_AT_RIGHT

#define USB_C_AT_BOTTOM(x,y) (y * 5 + x)
#define USB_C_AT_TOP(x,y) ((4 - y) * 5 + (4 - x))
#define USB_C_AT_LEFT(x,y) ((4 - x) * 5 + y)
#define USB_C_AT_RIGHT(x,y) (x * 5 + (4 - y))

uint8_t hex2int(uint8_t c) {
  if('0' <= c && c <= '9')
    return c - '0';
  else if('a' <= c && c <= 'f')
    return c - 'a' + 10;
  else if('A' <= c && c <= 'F')
    return c - 'A' + 10;
  else
    return 0;
}

#define color(r, g, b) (((r) << 16) | ((g) << 8) | (b))

boolean reset = false;

CRGB readHex(void) {
  uint8_t buf[6] = {0};
  int val, r, g, b;

  reset = false;   
  for(int i = 0; i < 6; i++) {
    do {
      val = Serial.read();
    } while(val < 0);
    if(val == '\n') { // LF means end of image -> force reset
      reset = true;
      break;
    }
    buf[i] = val;
  }
  r = hex2int(buf[0]) * 16 + hex2int(buf[1]);
  g = hex2int(buf[2]) * 16 + hex2int(buf[3]);
  b = hex2int(buf[4]) * 16 + hex2int(buf[5]);
  return color(r, g, b);
}

void setup() {

  Serial.begin(115200);
  M5.begin(true, false, true);

  for(int i = 0; i < 25; i++)
    M5.dis.drawpix(i, color(0x0, 0x0, 0x0));
}

void loop() {
  CRGB col;

  for(int y = 0; y < 5; y++) {
    for(int x = 0; x < 5; x++) {
      col = readHex();
      if(reset) { //unintended reset of image
        return;
      }
      M5.dis.drawpix(ORIENTATION_M5ATOM(x, y), col);
    }
  }
  M5.update();
}
