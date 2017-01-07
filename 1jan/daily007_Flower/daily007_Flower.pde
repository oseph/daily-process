/**
 * 007_Flower
 * by Josh Holinaty / Jan.04.2017
 * ---
 * Random flowers with (spiritual) perlin pollen.
 **/

boolean saveFrames = false;
FlowerFactory[] flowers;
int bgMin = 0;
int bgMax = 125;

void setup() {
    size(700, 700, P2D);
    noStroke();
    rectMode(CENTER);
    background(random(bgMin, bgMax), random(bgMin, bgMax), random(bgMin, bgMax));
    noiseSeed(0);
    flowers = new FlowerFactory[1];
    makeFlower();
}

void draw() {
    for (int i = 0; i < flowers.length; i++) {
        flowers[i].display();
    }

    if (saveFrames) {
        saveFrame("imgs/img-#####.png");
    }
}

void mousePressed() {
    background(random(bgMin, bgMax), random(bgMin, bgMax), random(bgMin, bgMax));
    makeFlower();
}

void makeFlower() {
    for (int i = 0; i < flowers.length; i++) {
        flowers[i] = new FlowerFactory(width/2, height/2, 10, width*.7);
    }
}

class Flower {
    float x;
    float y;
    float rectWidth;
    float rectHeight;
    float speed;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float n;
    float rot;
    float theta;
    float opacity;
    float rotFlip;
    float rectRad;
    int num;

    Flower(float x, float y, float size) {
        this.x = cos(theta) + x;
        this.y = sin(theta) + y;
        r = random(255);
        g = random(255);
        b = random(255);
        c = color(r, g, b);
        rectWidth = (int)random(50, size/2);
        rectHeight = (int)random(size/2, size);
        rx = random(0, 5000);
        rot = random(0, 2000);
        theta = random(100);
        opacity = random(150, 255);
        speed = 0.01;
        rotFlip = ( (int)random(100) < 50 ) ? 1: -1;
        rectRad = random(0, 20);
    }

    void updater() {
        n = noise(rx);
        rx += 0.05;
        rot++;
        theta -= speed;
        rectWidth--;
        rectHeight--;
        if (rectWidth < 5 || rectHeight < 5) {
            opacity = 0;
        }
    }

    void display() {
        fill(c, opacity);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*rotFlip));
        rect(0, 0, rectWidth, rectHeight, rectRad);
        rotate(radians(90));
        rect(0, 0, rectWidth, rectHeight, rectRad);
        popMatrix();
    }
}

class FlowerFactory {
    Flower[] flower;
    float x;
    float y;
    int num;
    float size;

    FlowerFactory(float x, float y, int num, float size) {
        this.x = x;
        this.y = y;
        this.num = num;
        this.size = size;
        flower = new Flower[num];    

        for (int i = 0; i < num; i++) {
            flower[i] = new Flower(x, y, size);
        }
    }

    void display() {
        for (int i = 0; i < num; i++) {
            flower[i].updater();
            flower[i].display();
        }
    }
}