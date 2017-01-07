/**
 * 005_RotatingRects 
 * by Josh Holinaty / Jan.02.2017
 * ---
 * Rectangles rotating away from the center of the window,
 * squeegeeing trails behind them with subtle perlinity.
 **/

int num = 100;
boolean saveFrames = false;
RotatingRects[] rotoRects = new RotatingRects[num];

void setup() {
    size(700, 700, P2D);
    noStroke();
    background(random(100, 255), random(100, 255), random(100, 255));
    makeRects();
}

void draw() {
    
    for (int i = 0; i < rotoRects.length; i++) {
        rotoRects[i].updater();
        rotoRects[i].display();
    }

    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
    
}

void mousePressed() {
    background(random(100, 255), random(100, 255), random(100, 255));
    makeRects();
}

void makeRects() {
    for (int i = 0; i < rotoRects.length; i++) {
        rotoRects[i] = new RotatingRects(i*15, i*15, random(150, 255));
    }
}

class RotatingRects {
    float x;
    float y;
    float rectWidth;
    float rectHeight;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float n;
    float rot;
    float theta;
    float opacity;
    float orbitDuration;
    float rotFlip;

    RotatingRects(float x, float y, float opacity) {
        theta = random(100);
        this.x = cos(theta) + x;
        this.y = sin(theta) + y;
        this.opacity = opacity;
        r = random(255);
        g = random(255);
        b = random(255);
        c = color(r, g, b);
        rectWidth = (int)random(5, width/3);
        rectHeight = (int)random(5, height/2);
        rx = random(0, 5000);
        rot = random(0, 2000); 
        rotFlip = ( (int)random(100) < 50 ) ? 1: -1;
    }

    void updater() {
        n = noise(rx);
        rx += 0.05;
        rot += n;
        y += random(0.4, 0.6);
        x += random(0.4, 0.6);
    }

    void display() {
        fill(c, opacity);
        pushMatrix();
        translate(width/2, height/2);
        rotate(radians(rot*rotFlip));
        translate(-rectWidth/2, -rectHeight/2);
        rect(x, y, rectWidth, rectHeight);
        popMatrix();
    }
}