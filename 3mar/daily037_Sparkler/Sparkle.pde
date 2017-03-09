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

  Sparkle() {
    setup();
  }

  void setup() {
    w = random(15);
    h = random(15);
    yDir = 1;
    xDir = 1;
    initX = mouseX;
    initY = mouseY;
    yPos = initY;
    xPos = initX;
    nOff = random(3000);
    len = random(40, 220);
    angle = random(360);
    speed = random(4, 6);
    lenLimit = random(150, 175);
    col = randCol();
    dead = false;
    strokew = 1;
    strokeCol = randCol();
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
    color c = color(random(100,155), random(150,255), random(150,255));
    return c;
  }

  void display() {
    pushMatrix();
    fill(col);
    stroke(strokeCol);
    translate(xPos, yPos);
    strokeWeight(strokew);
    rect(-w/2, -h/2, w, w);
    popMatrix();
  }

  void RectoidsetInit(float _x, float _y) {
    initX = _x;
    initY = _y;
  }

  boolean isDead() {
    return dead;
  }
}