/**
* 012-BallWaterFall
* by Josh Holinaty / Jan.09.2016
* ---
* Simple fun with Ricard Marxer's Fisica library (a JBox2D wrapper for Processing).
* http://www.ricardmarxer.com/fisica/
**/

import fisica.*;

boolean saveFrames = false;
int speed = 2;
int x = -100; // starting position of ball spawners
int y = -250; // starting position of ball spawners
int count = 0;
FWorld world;

void setup() {
    size(800, 800, P2D);
    smooth();
    Fisica.init(this);
    world = new FWorld();
}

void draw() {
   
    if (x > width+550) {
        x = -125;
    }

    if (count % 5 == 0) {
        makeFallBall(x+100);
        makeFallBall(x);
        makeFallBall(x-100);
    }
    
    x += speed;
    count++;
    world.step();
    world.draw();

    if (saveFrames) {
        saveFrame("imgs/img-####.png");
    }
    
}

void makeFallBall(int xloc) {
    float radius = random(10, 90);
    FCircle ball = new FCircle(radius);
    ball.setPosition(xloc+random(-10, 10), y+random(-10, 10));
    ball.setDensity(random(0, 50));
    ball.setFill(random(255), random(255), random(255));
    ball.setNoStroke();
    world.add(ball);
}