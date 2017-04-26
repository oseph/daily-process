/*
* 036_ImageMasking
* by Josh Holinaty / Mar.8.2017
* ---
* Have fun with images! Mask it up!
*/

// number of images in your data folder
int num = 1;
// best if they are named as img0.png, img1.png, img2.png ...
PImage[] arr = new PImage[num]; 

PImage master, master1;
PGraphics pg;
float ang;
PImage m1, bg;
PImage[] imgs;
float[] randos;

void setup() {
  size(800, 800, P2D);
  smooth();
  pg = createGraphics(width, height, P2D);
  ang = 0;
  for (int i = 0; i < arr.length; i++) {
    arr[i] = loadImage("img" + i + ".png");
    arr[i].resize(width,height);
  }
  initPics();
  bg = arr[(int)random(arr.length)];
}

void draw() {
  ang++;
  image(bg,0,0);
  for (int i = imgs.length-1; i > 0; i--) {
    drawRoto(imgs[i], width/2, height/2, randos[i]);
  }
}

// This function draws a ellipse circle onto our PGraphics buffer,
// captures it as an image, and uses the image as a mask.
// The resulting masked image is returned.
PImage makeMask (float w, float h) {
  int r = (int)random(arr.length);
  pg.beginDraw();
  pg.smooth();
  pg.background(0);
  pg.noStroke();
  pg.fill(255);
  pg.ellipse(pg.width/2, pg.height/2, w, h);
  m1 = pg.copy(); // get mask ellipse
  pg.clear();
  master = arr[r].copy();
  master.mask(m1);
  pg.image(master, 0, 0);
  pg.endDraw();
  m1 = pg.copy();
  return m1;
}

void drawRoto(PImage i, float x, float y, float r) {
  pushMatrix();
  translate(x, y);
  rotate(radians(ang*r));
  translate(-i.width/2, -i.height/2);
  image(i, 0, 0);
  popMatrix();
}

void mousePressed() {
  initPics();
}

void initPics() {
  int num = (int)random(4,15);
  imgs = new PImage[num];
  randos = new float[num];
  bg = arr[(int)random(arr.length)];
  float inc = (width)/imgs.length;
  ang = 0;
  float min = inc;
  for (int i = 0; i < imgs.length; i++) {
    imgs[i] = makeMask(inc*i, inc*i);
    randos[i] = random(-.2, .2);
    min += inc;
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame();
  }
}