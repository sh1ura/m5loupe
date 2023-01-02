#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <termios.h>

#define DEV_NAME "/dev/cu.usbserial-595E5B5B5B"
#define BAUD_RATE B115200

#define SHRINK 2 // 1 / magnification ratio
#define SIZE (5*SHRINK) // display size
#define OFFSET (1*SHRINK) // display offset

void sendColor(int fd) {
  uint8_t r, g, b;
  char buf[10];
  
  @autoreleasepool {
    CGPoint loc = CGEventGetLocation(CGEventCreate(NULL)); // get mouse location
        
    uint32_t count = 0;
    CGDirectDisplayID disp;
    if(CGGetDisplaysWithPoint(loc, 1, &disp, &count) != kCGErrorSuccess)
      return;

    int x = loc.x - CGDisplayBounds(disp).origin.x;
    int y = loc.y - CGDisplayBounds(disp).origin.y;
    CGImageRef image = CGDisplayCreateImageForRect(disp, CGRectMake(x - OFFSET, y - OFFSET, SIZE, SIZE));
    if(image != NULL) {
      NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc] initWithCGImage:image];

      for(int y = 0; y < SIZE; y += SHRINK) {
	for(int x = 0; x < SIZE; x += SHRINK) {
	  NSColor* color = [bitmap colorAtX:x y:y];
	  r = (uint8_t)([color   redComponent] * 255);
	  g = (uint8_t)([color greenComponent] * 255);
	  b = (uint8_t)([color  blueComponent] * 255);
	  //	  printf("%d %d %d\n", r, g, b);

	  sprintf(buf, "%02X%02X%02X", r, g, b);
	  if(write(fd, buf, 6) < 0) {
	    printf("Disconnected.\n");
	    exit(-1);
	  }
	}
      }
      [bitmap release];
      CGImageRelease(image);
    }
  }
  sprintf(buf, "\n"); // send a LF for end of image
  write(fd, buf, 1);
}

void serial_init(fd) {
  struct termios t;

  memset(&t, 0, sizeof(t));
  t.c_cflag = CS8 | CLOCAL | CREAD;
  t.c_cc[VTIME] = 100;
  cfsetispeed(&t, BAUD_RATE);
  cfsetospeed(&t, BAUD_RATE);
  tcsetattr(fd, TCSANOW, &t);
}

int main(int argc, const char * argv[]) {
  int serial_fd;
  
  serial_fd = open(DEV_NAME, O_RDWR | O_NONBLOCK );
  if(serial_fd < 0) {
    printf("Fail to open the serial port %s\n", DEV_NAME);
    exit(1);
  }
  serial_init(serial_fd);
  
  for(;;) {
    sendColor(serial_fd);
    usleep(1000 * 10);
  }

  return 0;
}
