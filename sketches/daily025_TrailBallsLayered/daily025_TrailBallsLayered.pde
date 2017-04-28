/**
 * 025_TrailBallLayered
 * by Josh Holinaty / Jan.24.2017
 * ---
 * Some balls in a room, bouncing around with some perlin noise.
 * Playing with ArrayLists to have trails.
 * Every trailing ball is drawn on it's own PGraphics. A little intensive if 
 * drawing a lot of shapes with long trails...
 **/

import java.util.Iterator;
import java.util.Queue;
import java.util.LinkedList;

// number of rectangles (high number = slow performance)
int num = 30; 

// save frames for movie making fun
boolean saveFrames = false; 
float shapeWidth = random(150,300);
Falling[] fallies= new Falling[num];

void setup() {
    size(700, 700, P2D);
    colorMode(HSB);
    makeRects();
}

void draw() { 
    background(255);
    for (int i = 0; i < fallies.length; i++) {
        fallies[i].display();
    } 
    if (saveFrames) {
        saveFrame("imgs6/img_#####.png");
    }
}

void mousePressed() {
    shapeWidth = random(150,300);
    makeRects();
}

void makeRects() {
    for (int i = 0; i < fallies.length; i++) {
        int trailLength = 2;
        fallies[i] = new Falling(random(100,width-100), random(100,height-100), trailLength, shapeWidth);
        shapeWidth -= shapeWidth/num;
    }
}