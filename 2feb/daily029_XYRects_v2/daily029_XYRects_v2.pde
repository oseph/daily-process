/**
 * 029_DancingRects_v2
 * by Josh Holinaty / Feb.03.2017
 * ---
 * Random rectangles dancing across the screen in both x and y axis, with perlin snuggles. 
 **/

int num = 15;
boolean saveFrames = false;
DancingRects[] dancies = new DancingRects[num];
int imgCount = 0;

void setup() {
    size(700, 700, P2D);
    colorMode(HSB);
    background(random(255), random(255), random(255));
    noStroke();
    makeRect();
}

void draw() {

    for (int i = 0; i < dancies.length; i++) {
        dancies[i].display();
        dancies[i].updater();
        dancies[i].grow();
    }
    if (saveFrames) {
        saveFrame("img"+imgCount+"/img-####.tga");
    }
}

void mousePressed() {
    if (saveFrames) {
        saveFrame("img"+imgCount+"/FINAL.tga");
    }
    imgCount++;
    background(random(255), random(255), random(255));
    makeRect();
}

void makeRect() {
    for (int i = 0; i < dancies.length; i++) {
        dancies[i] = new DancingRects(random(-50, width+50), random(-50, height+50));
    }
}