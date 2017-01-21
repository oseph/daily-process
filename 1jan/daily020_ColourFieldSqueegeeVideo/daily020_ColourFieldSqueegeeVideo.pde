/**
 * 020_ColourFieldSqueege
 * by Josh Holinaty / Jan.18.2017
 * ---
 * Rotating video ellipses squeegeeing across the screen making colour fields.
 * - mouse click resets
 **/
import processing.video.*;

Movie mov;
PGraphics pg;
boolean recordFrames = false;
int lo = 7; // min amount of squares
int hi = 12; // max amount of squares
int num = (int)random(lo, hi);
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
        squares[i].x = -50 - squares[i].squareWidth/2;
    }
    l = (int) random (255);
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
        saveFrame("imgs/img-#####.tga");
    }
}

void mousePressed() {
    flip = !flip;
    filterMode = !filterMode;
    l = (int) random (255);
    h = (int) random (l, 255);

    num = (int)random(lo, hi);
    squares = new Squares[num];
    for (int i = 0; i < num; i++) {
        if (flip) {
            squares[i] = new Squares(0, i*(height/num));
            squares[i].x = -50 - squares[i].squareWidth;
        }
        if (!flip) {
            squares[i] = new Squares(width, i*(height/num));
            squares[i].x = width + 50 + squares[i].squareWidth;
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

    Squares(float x, float y) {
        this.x = x;
        this.y = y;
        initX = x;
        iter = 0.05;    
        opacity = random(255);
        squareWidth = (int)(random(150, 350));
        speed = 4;
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = random (0, 100);
        rotFlip = (random(100) > 50) ? 1 : -1;
        rotIn = random(1);
        getX = (int)random(700);
        getX = constrain(getX, 0, width-(int)squareWidth);
        c = color(random(l, h), random(170), 255);
        mg = createGraphics((int)squareWidth, (int)squareWidth);
        mg.beginDraw();
        mg.ellipse((int)squareWidth/2, (int)squareWidth/2, (int)squareWidth, (int)squareWidth);
        mg.endDraw();
        m = mg.get();
    }

    void updater() {
        n = noise(rx);
        rx += iter;
        rot += rotIn;
    }

    void squeege() {
        if (initX < width/2) {
            x = (x+speed);
        } else {
            x = (x-speed);
        }

        if (n > 0.5) {   
            y = y+n*3;
        } else {
            y = y-n*3;
        }
    }

    void display() {
        tint(c, opacity);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*rotFlip));
        translate(-squareWidth/2, -squareWidth/2);
        img = pg.get(getX, getX, (int)squareWidth, (int)squareWidth);
        img.mask(m);
        if (filterMode) {
            img.filter(THRESHOLD, 0.4);
            blendMode(REPLACE);
        } else {blendMode(DIFFERENCE);}
        image(img, 0, 0, squareWidth, squareWidth);
        popMatrix();
    }
}

void movieEvent(Movie m) {
    m.read();
}