class Ball {
  FCircle ball;
  int life;
  
  Ball(float x, float y) {
    float radius = random(size/2,size);
    life = 0;
    ball = new FCircle(radius);
    ball.setPosition(x, y);
    ball.setDensity(random(0, 50));
    ball.setFill(col,random(255),random(255));
    ball.setNoStroke();
    world.add(ball);
  }

  void destroy() {
    world.remove(ball);
  }
  void updater() {
    if (life > 30) {
      destroy();
    }
    life++;
  }
}