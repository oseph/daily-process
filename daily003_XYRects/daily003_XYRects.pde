/**
 * 003_XYRects
 * by Josh Holinaty / Dec.31.2016
 * ---
 * Random rectangles dancing across the screen in both x and y axis, with perlin snuggles. 
 **/

int num = 75;
boolean saveFrames = false;
DancingRects[] dancies = new DancingRects[num];

void setup() {
    size(700, 700);
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    makeRect();
}

void draw() {
    for (int i = 0; i < dancies.length; i++) {
        dancies[i].display();
        dancies[i].updater();
        if (i % 2 == 0) {
            dancies[i].growVert();
        } else {
            dancies[i].growHoriz();
        }
    }
    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    background(random(255), random(255), random(255));
    makeRect();
}

void makeRect() {
    for (int i = 0; i < dancies.length; i++) {
        dancies[i] = new DancingRects(random(-50, width+50), random(-50, height+50));
    }
}

class DancingRects {
    float x;
    float y;
    float initY;
    float rectWidth;
    float rectHeight;
    float speed;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;

    DancingRects(float x, float y) {
        this.x = x;
        this.y = y;
        initY = y;
        iter = 0.05;
        c = color(random(235), random(235), random(235), random(255));
        r = random(255);
        g = random(255);
        b = random(255);
        rectWidth = (int)random(10, width/3);
        rectHeight = (int)random(10, height/3);
        speed = random(2, 5);
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = random(0, 360);
    }

    void updater() {
        n = noise(rx);
        rx += iter;
        rot += n;
    }

    void growVert() {
        // if fitt is spawned in upper half
        // it grows downward, else
        if (initY <= midwayLimit) {
            y = (y+speed);
        } else {
            y = (y-speed);
        }

        if (n > 0.5) {
            // n*x: x affects max range of horizonal variation
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

    void display() {
        fill(c, 40);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot));
        translate(-rectWidth/2, -rectHeight/2);
        rect(0, 0, rectWidth, rectHeight);
        popMatrix();
    }
}