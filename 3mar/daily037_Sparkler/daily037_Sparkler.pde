/* 
* 037_Sparkler
* by Josh Holinaty / Mar.9.2017
* ---
* For r/processing's weekly challenge. Theme is "Anniversary"
*/

ArrayList<Sparkle> sparkles;
int num = 150;
float candleW = 20;
void setup() {
  size(800,800, P2D);
  colorMode(HSB);
  sparkles = new ArrayList<Sparkle>();
  for (int i = 0; i < num; i++) {
    sparkles.add(new Sparkle());
  }
}

void draw() {
  
  background(230, 50, 100);
  noStroke();
  fill(255);
  rect(mouseX-candleW/2, mouseY, candleW, height/2);
  //if (sparkles.size() < 100) {
  //  sparkles.add(new Sparkle());
  //} 
  
  for (Sparkle s: sparkles) {
    if (s.isDead()) {
      s.setup();
    }
    s.particle();
    s.display();
  }
}