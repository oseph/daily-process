/**
 * 001_FallingRects
 * by Josh Holinaty / Dec.29.2016
 * ---
 * Random falling rectangles with perlin noise kisses.
 **/

int num = 50; // number of rectangles
boolean saveFrames = false; // save frames for movie making fun
FallingRect[] fallies= new FallingRect[num];

void setup() {
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    size(700, 700);
    makeRects();
}

void draw() {
    for (int i = 0; i < fallies.length; i++) {
        fallies[i].display();
        fallies[i].grow();
    }

    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    background(random(255), random(255), random(255));
    makeRects();
}

void makeRects() {
    for (int i = 0; i < fallies.length; i++) {
        fallies[i] = new FallingRect(random(-50, width+50), -50);
    }
}

class FallingRect {
    float x;
    float y;
    float rectWidth;
    float rectHeight;
    float speed;
    color c;
    float iter;
    float rx;

    FallingRect(float x, float y) {
        this.x = x;
        this.y = y;
        iter = 0.03;
        c = color(random(235), random(235), random(235), random(255));
        rectWidth = (int)(random(5, width/3));
        rectHeight = (int)(random(5, height/3));
        speed = random(2, 7);
        rx = random(0, 5000);
    }

    void grow() {
        float n = noise(rx);
        rx += iter;
        y+=speed;

        if (n > 0.5) {
            x = x+n;
        } else {
            x = x-n;
        }
    }

    void display() {
        fill(c, 40);
        rect(x, y, rectWidth, rectHeight);
    }
}