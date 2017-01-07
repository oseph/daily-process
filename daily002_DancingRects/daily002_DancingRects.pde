/**
 * 002_DancingRects
 * by Josh Holinaty / Dec.30.2016
 * ---
 * Random rectangles falling and rising with perlin noise hugs.
 **/

int num = 50; // number of rectangles
boolean saveFrames = false;  // save frames for movie making fun
DancingRects[] dancies = new DancingRects[num];

void setup() {
    size(700, 700);
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    makeRects();
}

void draw() {
    for (int i = 0; i < dancies.length; i++) {
        dancies[i].display();
        dancies[i].grow();
    }
    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    background(random(255));
    makeRects();
}

void makeRects() {
    for (int i = 0; i < dancies.length; i++) {
        dancies[i] = new DancingRects(random(-50, width+50), random(-50, height+50));
    }
}

class DancingRects {
    float x;
    float initY;
    float y;
    float rectWidth;
    float rectHeight;
    float speed;
    float maxLife;
    float life = 0;
    color c;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;

    DancingRects(float x, float y) {
        this.x = x;
        this.y = y;
        initY = y;
        iter = 0.03; // increase for more dynamic dancing
        maxLife = height;
        c = color(random(235), random(235), random(235), random(255));
        rectWidth = (int)random(5, width/3);
        rectHeight = (int)random(5, width/3);
        speed = random(2, 7);
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = random(0, 180);
    }

    void grow() {
        n = noise(rx);
        rx += iter;
        rot+= n;
        
        // if rectangle is spawned in upper half
        // it grows downward, else upward
        if (initY <= midwayLimit) {
            y = (y+speed);
        } else {
            y = (y-speed);
        }
        
        // perlin noise affecting movement
        if (n > 0.5) {
            x = x+n;
        } else {
            x = x-n;
        }
    }

    void display() {
        fill(c, 40);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*n));
        translate(-rectWidth/2, -rectHeight/2);
        rect(0, 0, rectWidth, rectHeight);
        popMatrix();
    }
}