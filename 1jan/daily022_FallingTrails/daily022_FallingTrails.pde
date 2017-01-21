/**
 * 022_TrailingShapes
 * by Josh Holinaty / Dec.29.2016
 * ---
 * Fun with ArrayList and creating object trails.
 * Yes, with a kiss of perlin noise.
 * Yup, also some erosion filter.
 **/

int num = 28; // number of rectangles
boolean saveFrames = false; // save frames for movie making fun
Falling[] fallies= new Falling[num];
boolean filterFlip;

void setup() {
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    size(700, 700);
    makeRects();
}

void draw() {
    background(120);
    //if (filterFlip) {
        filter(LIGHTEST);
    //} else {
    //    filter(DILATE);
    //}

    for (int i = 0; i < fallies.length; i++) {
        fallies[i].display();
    }

    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    makeRects();
    filterFlip = !filterFlip;
}

void makeRects() {
    for (int i = 0; i < fallies.length; i++) {
        fallies[i] = new Falling(random(-50, width+20), i*-20, (int)random(50,200));
    }
}