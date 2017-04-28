/**
 * 014-Presidential
 * by Josh Holinaty / Jan.11.2016
 * ---
 * Kompromat. 
 * Simple fun with Ricard Marxer's Fisica library. 
 * (a JBox2D wrapper for Processing)
 * http://www.ricardmarxer.com/fisica/
 **/

import fisica.*;

boolean saveFrames = false;
PImage bathe;
int speed = 4;
int x = 0; // starting position
int y = -450; // starting position
int count = 0;
FWorld world;
FPoly myPoly;

void setup() {
    size(800, 800, P2D);
    background(100);
    smooth();
    bathe = loadImage("bw.png");
    tint(255, 125, 0);
    image(bathe, 100, 500);
    Fisica.init(this);
    world = new FWorld();
    world.setGravity(0, 90.81);
    makePres();
}

void draw() {

    if (x > 100 || x < -100) {
        speed = speed *-1;
    } 

    if (count % 5 == 0) {
        makeFallBall(x+width/2-300);
        makeFallBall(x+width/2-200);
        makeFallBall(x+width/2-100);
        makeFallBall(x+width/2);
        makeFallBall(x+width/2+100);
        makeFallBall(x+width/2+200);
        makeFallBall(x+width/2+300);
    }
    x+=speed;
    count++;
    world.step(0.05);
    world.draw();

    if (saveFrames) {
        saveFrame("imgs/img-####.png");
    }
}

void makeFallBall(int xloc) {
    int yellow = (int)random(200, 255);
    float radius = random(10, 30);
    FCircle ball = new FCircle(radius);
    ball.setPosition(xloc, y);
    ball.setDensity(0.5);
    ball.setFriction(0);
    ball.addForce(random(-20, 20), 100);
    ball.setVelocity(random(-20, 20), 100);
    ball.setRestitution(0.4);
    ball.setFill(yellow, yellow, 0);
    ball.setNoStroke();
    world.add(ball);
}

void makePres() {
    myPoly = new FPoly();
    myPoly.vertex(145, 797);
    myPoly.vertex(144, 746);
    myPoly.vertex(164, 688);
    myPoly.vertex(150, 653);
    myPoly.vertex(169, 627);
    myPoly.vertex(186, 584);
    myPoly.vertex(217, 568);
    myPoly.vertex(265, 564);
    myPoly.vertex(331, 540);
    myPoly.vertex(441, 521);
    myPoly.vertex(463, 513);
    myPoly.vertex(473, 513);
    myPoly.vertex(630, 579);
    myPoly.vertex(643, 603);
    myPoly.vertex(634, 612);
    myPoly.vertex(639, 635);
    myPoly.vertex(653, 650);
    myPoly.vertex(660, 710);
    myPoly.vertex(664, 735);
    myPoly.vertex(674, 769);
    myPoly.vertex(678, 798);
    myPoly.setFill(0, 0);
    myPoly.setNoStroke();
    myPoly.setRestitution(0.5);
    myPoly.setFriction(0);
    myPoly.setStatic(true);
    world.add(myPoly);
}