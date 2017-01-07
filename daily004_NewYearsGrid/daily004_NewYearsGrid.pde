/**
 * 004_NewYearsGrid
 * by Josh Holinaty / Jan.01.2017 [Happy New Year!]
 * ---
 * A grid of 2016 rectangles, dancing off the stage with perlin swagger.
 * Click to start.
 **/

Rectangules[][] recties;
float rectWidth;
float rectHeight;
boolean saveFrames = false;
boolean starter = false;
int rows = 36;
int cols = 56;

void setup() {
    size(1008, 1008); // make sure w/h are divisible my rows and cols
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    rectWidth = width/rows;
    rectHeight = height/cols;
    recties = new Rectangules[rows][cols];
    makeRects();
}

void draw() {
    for (int i = 0; i < recties.length; i++) {
        for (int j = 0; j < recties[i].length; j++) {
            recties[i][j].display();
            if (starter) {
                recties[i][j].updater();
                if (i % 2 == 0 && j % 2 == 0) {
                    recties[i][j].growVert();
                } else {
                    recties[i][j].growHoriz();
                }
            }
        }
    }
    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    starter = true;
    makeRects();
}

void makeRects() {
    for (int i = 0; i < recties.length; i++) {
        for (int j = 0; j < recties[i].length; j++) {
            recties[i][j] = new Rectangules(i*rectWidth, j*rectHeight);
        }
    }
}

class Rectangules {
    float x;
    float y;
    float initY;
    float speed;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;
    float rotFlip;

    Rectangules(float x, float y) {
        this.x = x+rectWidth;
        this.y = y+rectHeight;
        initY = y;
        iter = 0.05;
        c = color(random(100, 255), random(100, 255), random(100, 255));
        r = random(255);
        g = random(255);
        b = random(255);
        speed = random(1, 3);
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = 0;
        rotFlip = (random(100) > 50) ? 1 : -1;
    }

    void growVert() {
        
        // if fitt is spawned in upper half
        // it grows downward, else...
        if (initY <= midwayLimit) {
            y = (y+speed);
        } else {
            y = (y-speed);
        }
        
        if (n > 0.5) {
            x = x+n;
        } else {
            x = x-n;
        }
    }

    void growHoriz() {
        
        // if rectangle is spawned in left half, move right, else left.
        if (initY <= midwayLimit) {
            x = (x+speed);
        } else {
            x = (x-speed);
        }

        if (n > 0.5) { 
            y = y+n;
        } else {
            y = y-n;
        }
    }

    void updater() {
        n = noise(rx);
        rx += iter;
        rot+=n;
    }

    void display() {
        fill(c);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*rotFlip));
        translate(-rectWidth, -rectHeight);
        rect(0, 0, rectWidth, rectHeight);
        popMatrix();
    }
}