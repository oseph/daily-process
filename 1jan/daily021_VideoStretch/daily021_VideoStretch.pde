/**
 * 021_VideoStrips
 * by Josh Holinaty / Jan.18.2017
 * ---
 * Autopainting with a video strips.
 * - mouse click resets
 **/
import processing.video.*;

Movie mov;
PGraphics pg;
boolean recordFrames = true;
int num = 1;
Squares[] squares = new Squares[num];
boolean flip = true; // squares alternate which side they enter the screen
color c;
int l, h;
boolean filterMode = false; // threshfold filter on/off

void setup() {
    size(700, 700);
    pg = createGraphics(700, 700);
    mov = new Movie(this, "j1.mp4");
    mov.loop();
    colorMode(HSB);
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    for (int i = 0; i < num; i++) {
        squares[i] = new Squares(0, i*(height/num));
        squares[i].x = 0 - squares[i].squareWidth;
    }
    l = (int) random (200);
    h = (int) random (l, 255);
    c = color(random(l, h), random(150, 255), 255);
}

void draw() {
    pg.beginDraw();
    pg.image(mov, 0, 0);
    pg.endDraw();
    for (int i = 0; i < squares.length; i++) {
        squares[i].updater();
        squares[i].squeege();
        squares[i].display();
    }
    if (recordFrames) {
        saveFrame("imgs2/img-#####.tga");
    }
}

void mousePressed() {
    flip = !flip;
    filterMode = !filterMode;
    num = 1;
    squares = new Squares[num];
    l = (int) random (200);
    h = (int) random (l, 255);
    for (int i = 0; i < num; i++) {
        if (flip) {
            squares[i] = new Squares(0, i*(height/num));
            squares[i].x = 0 - squares[i].squareWidth;
        }
        if (!flip) {
            squares[i] = new Squares(0, -50);
        }
    }
}

class Squares {
    float x;
    float y;
    float initX;
    float squareWidth;
    float speed;
    float opacity;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;
    float rotFlip;
    float rotIn;
    int getX;
    PImage img;
    PImage m;
    PGraphics mg;
    color c;
    int putX;

    Squares(float x, float y) {
        this.x = x;
        this.y = y;
        initX = x;
        iter = 0.05;    
        opacity = random(80, 160);
        squareWidth = 50;
        speed = (int)random(2, 5);
        rx = random(0, 5000);
        rot = random (0, 100);
        rotFlip = (random(100) > 50) ? 1 : -1;
        rotIn = random(1);
        getX = (int)random(300,401);
        getX = constrain(getX, 0, width-(int)squareWidth);
        c = color(random(l, h), random(170), 255);
        mg = createGraphics((int)squareWidth, (int)squareWidth);
        mg.beginDraw();
        mg.ellipse((int)squareWidth/2, (int)squareWidth/2, (int)squareWidth, (int)squareWidth);
        mg.endDraw();
        m = mg.get();
        putX = (int) random(-50, 150);
    }

    void updater() {
        n = noise(rx);
        rx += iter;

    }

    void squeege() {
        if (!flip) {

            y = (y+speed);
            if (n > 0.5) {   
                x = x+n;
            } else {
                x = x-n;
            }
        } else {
            if (initX < width/2) {
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
    }

    void display() {

        pushMatrix();
        translate(x, y);
        if (!flip) {
            img = pg.get(0, getX, width, (int)squareWidth);
            blendMode(LIGHTEST);
            tint(c, 200);
            image(img, 0, 0, width, (int)squareWidth);
        } else {
            img = pg.get(getX, 0, (int)squareWidth, height);
            blendMode(LIGHTEST);
            tint(c, 200);
            image(img, 0, putX, squareWidth, height-putX);
        }

        popMatrix();
    }
}

void movieEvent(Movie m) {
    m.read();
}