/**
 * 024_TrailRoomBalls
 * by Josh Holinaty / Jan.23.2017
 * ---
 * Some balls in a room, bouncing around with some perlin noise.
 * Playing with ArrayLists for shape trails.
 **/

import java.util.Iterator;
import java.util.Queue;
import java.util.LinkedList;

int num = 60; // number of shapes
boolean saveFrames = false; // save frames for movie making fun
Falling[] fallies= new Falling[num];

int life = 0;
int lifeTime;
float shapeWidth = random(50, 150);

void setup() {
    size(700, 700, P2D);
    noStroke();
    colorMode(HSB);
    makeShapes();
}

void draw() { 
    background(0);
    for (int i = 0; i < fallies.length; i++) {
        fallies[i].display();
    }

    if (saveFrames) {
        saveFrame("imgs4/img_#####.png");
    }
}

void mousePressed() {
    shapeWidth = random(100, 150);
    makeShapes();
}

void makeShapes() {
    for (int i = 0; i < fallies.length; i++) {
        int trailLength = (int) random(5, 50);
        fallies[i] = new Falling(random(100, width-100), random(100, height-100), trailLength, shapeWidth);
        shapeWidth -= 3;
    }
}