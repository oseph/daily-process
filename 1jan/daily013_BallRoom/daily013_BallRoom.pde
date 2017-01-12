/**
 * 013-BallRoom
 * by Josh Holinaty / Jan.10.2016
 * ---
 * Help! We're trapped in a room!
 * More simple fun with Ricard Marxer's Fisica library.
 * (a JBox2D wrapper for Processing)
 * http://www.ricardmarxer.com/fisica/
 **/

import fisica.*;

boolean saveFrames = false;
int wcount = 0;
int bcount = 0;
FWorld world1;

void setup() {
    size(800, 800, P2D);
    smooth();
    Fisica.init(this);
    world1 = new FWorld();
    world1.setGravity(0, 0);
    world1.setEdges(6, 6, width-6, height-6, 255);
}

void draw() {

    if (bcount < 100) {
        makeFallBall1();
        bcount++;
    }

    wcount++;
    world1.step(0.5);
    world1.draw();

    if (wcount % 50 == 0) {
        world1.setGravity(random(-15, 15), random(-15, 15));
    }

    if (saveFrames) {
        saveFrame("imgs/img-####.png");
    }
}

void makeFallBall1() {
    float radius = random(10, 150);
    FCircle ball = new FCircle(radius);
    ball.setPosition((width/2)+random(-20, 20), (height/2)+random(-20, 20));
    ball.setDensity(random(6, 50));
    ball.setDamping(random(1));
    ball.setVelocity(random(-50, 50), random(-50, 50));
    ball.setFill(random(225), random(225), random(225));
    ball.setNoStroke();
    world1.add(ball);
}

void mousePressed() {
    loop();
    background(random(255));
    wcount = 0;
    bcount = 0;
    world1.clear();
    world1.setGravity(random(-15, 15), random(-15, 15));
    world1.setEdges(6, 6, width-6, height-6, 255);
}