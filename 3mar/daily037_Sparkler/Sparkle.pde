class Sparkle {

  boolean dead;
  float initX;
  float initY;
  int xDir, yDir;
  float rot;
  float nOff;
  float w, h, len, angle, speed, lenLimit;
  float xPos, yPos;
  color col, strokeCol;
  float strokew;
  boolean shape;

  Sparkle() {
    setup();
  }

  void setup() {
    w = random(15);
    h = random(15);
    yDir = 1;
    xDir = 1;
    initX = x;
    initY = y;
    yPos = initY;
    xPos = initX;
    nOff = random(3000);
    len = random(20, 220);
    angle = random(360);
    speed = random(4, 6);
    lenLimit = random(150, 175);
    col = randCol();
    dead = false;
    strokew = 1;
    float r = red(col);
    float g = green(col);
    float b = blue(col);
    strokeCol = color(g, r, b);
    shape = (random(1) > 0.5) ? true : false;
  }

  void particle() {
    if (len > lenLimit) {
      dead = true;
    }
    xPos = initX + cos(radians(angle))*len;
    yPos = initY + sin(radians(angle))*len;
    len += speed;
    angle += random(-0.5, 0.5);
    w += speed*0.1;
    h += speed*0.1;
    strokew+= 0.08;
  }

  color randCol() {
    color c = color(random(215, 255), random(215, 255), random(215, 255));
    return c;
  }

  void display() {
    pushMatrix();
    fill(255);
    stroke(255);
    translate(xPos, yPos);
    noStroke();
    ellipse(-w/2, -h/2, w, w);
    popMatrix();
  }

  boolean isDead() {
    return dead;
  }
}