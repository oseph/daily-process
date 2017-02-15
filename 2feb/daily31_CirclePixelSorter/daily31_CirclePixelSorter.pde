/**
 * 031_CirclePixelSorterA
 * by Josh Holinaty / Feb.11.2017
 * ---
 * Pixel sorting a circle.
 **/
 
PImage img;
int CENTER_X; // center of circle
int CENTER_Y; // center of circle
int r;

void setup() {
  img = loadImage("--your_Image--");
  size(800, 800);
  image(img, 0, 0);
  CENTER_X = width/2;
  CENTER_Y = height/2;
  r = 360;
}

void draw() {
  sortUnCircle();
  sortCircleY();
  sortCircleX();
}

// Sort the pixels that aren't in the circle
void sortUnCircle() {
  loadPixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = x + y * width;
      if ((x - CENTER_X) * (x - CENTER_X) + (y - CENTER_Y) * (y - CENTER_Y) > r * r &&
        ((x-1) - CENTER_X) * ((x-1) - CENTER_X) + (y - CENTER_Y) * (y - CENTER_Y) > r * r) {
        float p1 = brightness(pixels[loc-1]);
        float p2 = brightness(pixels[loc]);
        if (p1 > p2) {
          int tmp = pixels[loc-1];
          pixels[loc-1] = pixels[loc];
          pixels[loc] = tmp;
        }
      }
    }
  }
  updatePixels();
}

// sort pixel rows in circle
void sortCircleX() {
  loadPixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {
      if ((x - CENTER_X) * (x - CENTER_X) + (y - CENTER_Y) * (y - CENTER_Y) <= r * r &&
        ((x-1) - CENTER_X) * ((x-1) - CENTER_X) + (y - CENTER_Y) * (y - CENTER_Y) <= r * r) {
        int loc1 = (x-1) + y * width; 
        int loc2 = x + y * width; 
        float p1 = brightness(pixels[loc1]);
        float p2 = brightness(pixels[loc2]);
        if (p1 > p2) {
          int tmp = pixels[loc1];
          pixels[loc1] = pixels[loc2];
          pixels[loc2] = tmp;
        }
      }
    }
  }
  updatePixels();
}

// sort pixel columns in circle
void sortCircleY() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 1; y < height; y++) {    
      if ((x - CENTER_X) * (x - CENTER_X) + (y - CENTER_Y) * (y - CENTER_Y) <= r * r &&
        (x - CENTER_X) * (x - CENTER_X) + ((y-1) - CENTER_Y) * ((y-1) - CENTER_Y) <= r * r) {
        int loc1 = x + (y-1) * width;  
        int loc2 = x + y * width;     
        float p1 = brightness(pixels[loc1]);
        float p2 = brightness(pixels[loc2]);
        if (p1 > p2) {
          int tmp = pixels[loc1];
          pixels[loc1] = pixels[loc2];
          pixels[loc2] = tmp;
        }
      }
    }
  }
  updatePixels();
}