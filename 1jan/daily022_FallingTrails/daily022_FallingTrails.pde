/**
 * 022_FallingTrails
 * by Josh Holinaty / Jan.21.2017
 * ---
 * Fun with ArrayList and creating object trails.
 * Yes, with a kiss of perlin noise.
 * Yup, also some erosion filter.
 **/
 
import java.util.Iterator;
import java.util.Queue;
import java.util.LinkedList;

int num = 50; // number of rectangles
boolean saveFrames = false; // save frames for movie making fun
Falling[] fallies= new Falling[num];
boolean filterFlip;
int trailLength = (int) random(5,80);

void setup() {
    size(700, 700, P2D);
    smooth();
    noStroke();
    makeShapes();
}

void draw() {
    filter(ERODE);
    for (int i = 0; i < fallies.length; i++) {
        fallies[i].display();
    }

    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    makeShapes();
    filterFlip = !filterFlip;
}

void makeShapes() {
    for (int i = 0; i < fallies.length; i++) {
        fallies[i] = new Falling(random(-50, width+20), -10*i, trailLength);
    }
}