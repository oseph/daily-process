/**
 * 006_ColourFieldSqueege
 * by Josh Holinaty / Jan.03.2017
 * ---
 * Rotating squares squeegeeing across the screen making colour fields.
 * - mouse click resets
 **/

boolean recordFrames = false;
int lo = 5; // min amount of squares
int hi = 10; // max amount of squares
int num = (int)random(lo, hi);
Squares[] squares = new Squares[num];
boolean flip = true; // squares alternate which side they enter the screen

void setup() {
    size(700, 700);
    background(random(255), random(255), random(255));
    noSmooth();
    noStroke();
    for (int i = 0; i < num; i++) {
        squares[i] = new Squares(0, i*(height/num));
        squares[i].x = 0-(squares[i].squareWidth/2);
    }
}

void draw() {
    for (int i = 0; i < squares.length; i++) {
        squares[i].updater();
        squares[i].squeege();
        squares[i].display();
    }
    if (recordFrames) {
        saveFrame("imgs/boop-#####.png");
    }
}

void mousePressed() {
    flip = !flip;
    num = (int)random(lo, hi);
    squares = new Squares[num];
    for (int i = 0; i < num; i++) {
        if (flip) {
            squares[i] = new Squares(0, i*(height/num));
            squares[i].x = 0-(squares[i].squareWidth/2);
        }
        if (!flip) {
            squares[i] = new Squares(width, i*(height/num));
            squares[i].x = width+(squares[i].squareWidth/2);
        }
    }
}

class Squares {
    float x;
    float y;
    float initX;
    float squareWidth;
    float speed;
    color c;
    float opacity;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;
    float rotFlip;
    float rotIn;

    Squares(float x, float y) {
        this.x = x;
        this.y = y;
        initX = x;
        iter = 0.05;
        c = color(random(255), random(255), random(255));
        opacity = random(100, 255);
        squareWidth = (int)(random(50, 350));
        speed = random(4, 6);
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = random (0, 100);
        rotFlip = (random(100) > 50) ? 1 : -1;
        rotIn = random(3);
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
        fill(c, opacity);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*rotFlip));
        translate(-squareWidth/2, -squareWidth/2);
        rect(0, 0, squareWidth, squareWidth);
        popMatrix();
    }
}