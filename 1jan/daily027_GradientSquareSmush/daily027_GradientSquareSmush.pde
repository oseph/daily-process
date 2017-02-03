/**
 * 027_GradientSquareSmush
 * by Josh Holinaty / Jan.31.2017
 * ---
 * Draw a gradient, grab a square, smush it around. Result: 2000s era EDM album art.
 **/

int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, b3;
PImage main;
PImage square;
PGraphics pg;
int x, y, w;
int waitTime;
int xdir, ydir;
int f; // grid resolution
boolean saveFrames = true;
int count;
int counter;

void setup() {
    size(700, 700);
    pg = createGraphics(700, 700);
    b1 = color(random(255), random(255), random(255));
    b2 = color(random(255), random(255), random(255));
    b3 = color(random(255), random(255), random(255));
    pg.beginDraw();
    setGradient(0, 0, width/3, height, b1, b2, X_AXIS);
    setGradient(width/3, 0, width/3, height, b2, b3, X_AXIS);
    setGradient(width-(width/3), 0, width/3, height, b3, b1, X_AXIS);
    pg.endDraw();
    main = pg.get();
    f = (int)random(1, 8);
    w = width/f;
    x = chooseSquare(f);
    y = chooseSquare(f);
    image(main, 0, 0);
    square = makeSquare(x, y, w);
    waitTime = (int)random(20, 150);
    xdir = (random(100) > 50) ? 1 : -1;
    ydir = (random(100) > 50) ? 1 : -1;
    counter = 0;
    count = 0;
}

void draw() { 
    if (counter < 50) {
        if (count > waitTime) {
            f = (int)random(1, 8);
            w = width/f;
            x = chooseSquare(f);
            y = chooseSquare(f);
            square = makeSquare(x, y, w);
            waitTime = (int)random(20, 150);
            xdir = (random(100) > 50) ? 1 : -1;
            ydir = (random(100) > 50) ? 1 : -1;
            count = 0;
            counter++;
        }
        x+=1*xdir;
        y+=1*ydir;

        image(square, x, y);
        count++;
        if (saveFrames) {
            saveFrame("img3/img-####.tga");
        }
    } else {
        if (saveFrames) {
            saveFrame("img3/final-####.tga");
        }
        noLoop(); 
    }
}

int chooseQuarter(int div) {
    int fact = (int)width/div;
    int x = (int)random(0, div+1);
    int size = 0;
    for (int i = 0; i < div; i++) {
        if (i == x) { 
            size = i*fact;
        }
    }
    return size;
}

int chooseSquare(int div) {
    int fact = (int)width/div;
    int x = (int)random(0, div+1);
    int size = 0;
    for (int i = 0; i < div; i++) {
        if (i == x) { 
            size = i*fact;
        }
    }
    return size;
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    pg.noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
        for (int i = y; i <= y+h; i++) {
            float inter = map(i, y, y+h, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(x, i, x+w, i);
        }
    } else if (axis == X_AXIS) {  // Left to right gradient
        for (int i = x; i <= x+w; i++) {
            float inter = map(i, x, x+w, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(i, y, i, y+h);
        }
    }
}

PImage makeSquare(int x, int y, int w) {
    PImage img = new PImage();
    img = get(x, y, w, w);
    return img;
}