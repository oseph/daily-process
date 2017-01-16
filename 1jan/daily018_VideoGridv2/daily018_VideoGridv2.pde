/**
 * 018_VideoGrid
 * by Josh Holinaty / Jan.15.2016
 * ---
 * Video offsetting.
 * MouseX changes amount of offset.
 * Click to randomly generate different grid resolutions.
 **/

import processing.video.*;

Movie mov;
PGraphics pg;
int numX, numY;
PImage[][] img;
int[][] offsetX;
int[][] offsetY;
int tileWidth, tileHeight;
int getX, getY;
int rndL = 4; // lowest possible grid dimension
int rndH = 21; // rndH-1 = highest possible grid dimension
int rndrng; 
int maxOff = 40; // max offset per tile
boolean realTime = false;

void setup() {
    size(720, 720);
    // make sure your vid is equal or larger than graphic size,
    // otherwise black pixels will appear.
    pg = createGraphics(720, 720); 
    mov = new Movie(this, "j1.mp4"); // inster your video path here
    mov.loop();
    numCheck();

    // create matrices with new lengths
    img = new PImage[numX][numY];
    offsetX = new int[numX][numY];
    offsetY = new int[numX][numY];

    // instantiate object matrices
    createTiles();
    createOffsets();
    
    shuffle();
}

void draw() {
    if (realTime) {
        rndrng = mouseX;
        rndrng = (int) map(rndrng, 0, width, 0, maxOff);
        createOffsets();
    }

    background(0);
    pg.beginDraw();
    pg.image(mov, 0, 0);

    for (int x = 0; x < numX; x++) {
        for (int y = 0; y < numY; y++) {
            getX = x*tileWidth + offsetX[x][y];
            getY = y*tileHeight + offsetY[x][y];
            getX = constrain(getX, 0, pg.width-tileWidth);
            getY = constrain(getY, 0, pg.height-tileHeight);
            img[x][y] = pg.get(getX, getY, tileWidth, tileHeight);
            image(img[x][y], x*tileWidth, y*tileHeight);
        }
    }
    pg.endDraw();
    //saveFrame("img1/img-####.tga");
}

void shuffle() {
    numCheck();
    tileWidth = width/numX;
    tileHeight = height/numY;
    img = new PImage[numX][numY];
    offsetX = new int[numX][numY];
    offsetY = new int[numX][numY];
    createOffsets();
    createTiles();
}

void mousePressed() {
    rndrng = mouseX;
    rndrng = (int) map(rndrng, 0, width, 0, maxOff);
    createOffsets();
    shuffle();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
    m.read();
}

void createTiles() {
    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            img[i][j] = new PImage();
        }
    }
}

void createOffsets() {
    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            offsetX[i][j] = (int) random(-rndrng, rndrng);
            offsetY[i][j] = (int) random(-rndrng, rndrng);
        }
    }
}

void keyPressed() {
    if (key == RETURN || key == ENTER) {
        realTime = !realTime;
    }
}

void numCheck() {
    numX = (int) random(rndL, rndH);
    numY = (int) random(rndL, rndH);
    while (width % numY != 0) {
        numY++;
    }
    while (width % numX != 0) {
        numX++;
    }
}