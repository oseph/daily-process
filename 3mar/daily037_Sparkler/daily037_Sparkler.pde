/* 
* 037_Sparkler
* by Josh Holinaty / Mar.9.2017
* ---
* For r/processing's weekly challenge. Theme is "Anniversary"
*/

ArrayList<Sparkle> sparkles;
float x,y;
int num = 150;
float candleW = 10;
float angle;

void setup() {
  size(800,800, P2D);
  sparkles = new ArrayList<Sparkle>();
  x = width/2;
  y = height/2;
  for (int i = 0; i < num; i++) {
    sparkles.add(new Sparkle());
  }
  background(230, 50, 100);
  angle = 0;
}

void draw() {
  
  angle+=3;
  x = width/2+cos(radians(angle))*50;
  y = height/2+sin(radians(angle))*50;
  background(230, 50, 100);
  stroke(255);
  strokeWeight(candleW);
  strokeCap(SQUARE);
  line(x, y, width/2, height);
  
  for (Sparkle s: sparkles) {
    if (s.isDead()) {
      s.setup();
    }
    s.particle();
    s.display();
  }
  
  saveFrame("img/img####.tga");
}