/**
* 034_SineCircles
* by Josh Holinaty / Feb.27.2016
* ---
* Drawing sine waves across a circle. It gets weird.
**/

float px, py;
float angle;
float x;
float inc;
float w = 3;
float[] values;
float theta = 0.0;
float amp = 20;
float dx = (TWO_PI / 120);
float circleRes = 10;
float size = 160;

void setup() {
  size(600, 600, P2D);
  background(0);
  values = new float[(int)circleRes];
  strokeWeight(w);
  angle = random(360);
  inc = 0;
}

void draw() {
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(w);

  // with mouse affectings. 
  amp = map(mouseX, 50, width-50, 0, 100);
  w = map(mouseX, 50, width-50, 20, 1); 
  circleRes = map(mouseY, 50, height-50, 1, 10);
  
  amp = constrain(amp, 0, 100);
  w = constrain(w, 1, 20);
  circleRes = constrain(circleRes, 1, 25);
  values = new float[(int)circleRes];

  // draw the points
  for (int i = 0; i < values.length; i++) {
    theta += dx;
    values[i] = sin(theta)*(amp);
    px = cos(radians(angle))*(values[i]+size);
    py = sin(radians(angle))*(values[i]+size);
    point(px, py);
  }
  angle+=0.8;
}

void mousePressed() {
  background(0);
  angle = random(360);
  inc = 0;
}