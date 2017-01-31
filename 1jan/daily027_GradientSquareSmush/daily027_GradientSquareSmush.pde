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
int f = 4; // grid resolution
boolean saveFrames = false;

void setup() {
    size(700, 700);
    pg = createGraphics(700, 700);
    colorMode(HSB);
    b1 = color(random(255), random(255), random(255));
    b2 = color(random(255), random(255), random(255));
    b3 = color(random(255), random(255), random(255));
    pg.beginDraw();
    setGradient(0, 0, width/4, height, b3, b1, X_AXIS);
    setGradient(width/4, 0, width/4, height, b1, b2, X_AXIS);
    setGradient(width/2, 0, width, height, b2, b3, X_AXIS);
    pg.endDraw();
    main = pg.get();
    w = width/f;
    x = chooseSquare();
    y = chooseSquare();
    if (x < 0) { 
        x = 0;
    } else if ( x > width) { 
        x = width-w;
    }
    if (y < 0) { 
        y = 0;
    } else if ( y > height) { 
        y = height-w;
    }
    image(main, 0, 0);
    square = makeSquare(x, y, w);
    waitTime = (int)random(50,150);
    xdir = (random(100) > 50) ? 1 : -1;
    ydir = (random(100) > 50) ? 1 : -1;
}

void draw() { 
    //blendMode(LIGHTEST);
    if (frameCount % waitTime == 0) {
        w = width/f;
        x = chooseSquare();
        y = chooseSquare();
        square = makeSquare(x, y, w);
        waitTime = (int)random(50,150);
        xdir = (random(100) > 50) ? 1 : -1;
        ydir = (random(100) > 50) ? 1 : -1;
    }
    x+=1*xdir;
    y+=1*ydir;
  
    image(square, x, y);

    if (saveFrames) {
        saveFrame("img11/img-####.tga");
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
int chooseSquare() {
    int fact = (int)width/8;
    int i = (int)random(0, 9);
    if (i == 0) {
        return fact*0; // 0
    } else if (i == 1) {
        return fact*1; // 1/8
    } else if (i == 2) {
        return fact*2; // 2/8
    } else if (i == 3) { 
        return fact*3; //3/8
    } else if (i == 4) { 
        return fact*4; //4/8
    } else if (i == 5) { 
        return fact*5; //5/8
    } else if (i == 6) { 
        return fact*6; //5/8
    } else { 
        return fact*7; //7/8
    }
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