/** 
 * 033_ColourStrips
 * by Josh Holinaty / Feb.18.2016
 * ---
 * Box of Crayons Simulator 9000.
 * Click to restart.
 **/

boolean saveFrames = false;
float x, y, strW, count; 
boolean flip;
color str;
float s, len;
float ang;
float inc;
float ringRes;
int rotoCount, mainCount;
float num;
float colr, colg, colb;
float colrInc, colgInc, colbInc;

void setup() {
  size(800, 800);
  //colorMode(HSB);
  background(colr, colg, colb);
  //noSmooth();
  str = color(random(255));
  strW = 5;
  s = 10;
  len = 1000;
  ang = 0;
  inc = 1;
  count = 1;
  num = 10;
  colr = random(255);
  colg = random(255);
  colb = random(255);
  colrInc = random(2);
  colgInc = random(2);
  colbInc = random(2);
  background(colr, colg, colb);

}

void draw() {
  if (inc > 360) {
    rotoCount++;
    inc = 0;
    strW += 0.5;
    num += 20;
  }
  if (rotoCount > 0) {
    rotoCount = 0;
    mainCount++;
  }
  
  if (flip) { 
    ang -= 360/num;
  } else {
    ang += 360/num;
  }
  
  translate(width/2, height/2);
  float sx = sin(radians(ang)) * (s+random(-5, 5));
  float sy = cos(radians(ang)) * (s+random(-5, 5));
  float ex = sin(radians(ang)) * (len+random(-5, 5));
  float ey = cos(radians(ang)) * (len+random(-5, 5));
  strokeWeight(strW);
  str = color(colr,colg, colb);
  stroke(str);
  line(sx, sy, ex, ey);
  inc += 360/num;
  if (colr > 255 || colr < 0) { colrInc *= -1;}
  if (colg > 255 || colg < 0) { colgInc *= -1;}
  if (colb > 255 || colb < 0) { colbInc *= -1;}
  colr = (colr + colrInc);
  colg = (colg + colgInc);
  colb = (colb + colbInc);
  s += 40/num;

  if (saveFrames) {
    saveFrame("imgs5/img-#####.tga");
  }
}