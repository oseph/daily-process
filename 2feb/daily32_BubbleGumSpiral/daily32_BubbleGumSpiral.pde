/** //<>//
 * 032_BubbleGumSpiral
 * by Josh Holinaty / Jan.14.2016
 * ---
 * Simple fun with Ricard Marxer's Fisica library (a JBox2D wrapper for Processing).
 * http://www.ricardmarxer.com/fisica/
 *
 * This code is ugly.
 **/

import fisica.*;
float angle;
boolean saveFrames = false;
FWorld world;
float len;
color c;
float inc;
float col;
int size;
int colInc;
int sizeInc;

ArrayList<Ball> balls = new ArrayList<Ball>();
void setup() {
  size(800, 800, P2D);
  smooth();
  Fisica.init(this);
  world = new FWorld();
  angle = 0;
  len = 25;
  inc = 50;
  size = 20;
  col = 0;
  colInc = 50;
  sizeInc = 15;
  world.setGravity(0,0);
}

void draw() {
  //background(0);
  if (len > width*.6 || len < 10) {
     sizeInc *= -1;
     inc *= -1;
  }
  
  if (angle > 360) {
    angle = 0;
    len += inc;
    size += sizeInc;
    if (size < 20) {size = 20;}
    if (col > 255 || col < 0) {colInc *= -1;}
    col += colInc;
  } 
  for (Ball b: balls) {
    b.updater();
  }
  
  float sx = sin(radians(angle)) * len;
  float sy = cos(radians(angle)) * len;
  balls.add(new Ball(sx, sy));
  translate(width/2, height/2);
  world.step();
  world.draw();
  angle+=5;
}