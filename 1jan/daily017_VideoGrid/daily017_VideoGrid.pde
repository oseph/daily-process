/**
 * 017_VideoGrid
 * by Josh Holinaty / Jan.14.2016
 * ---
 * Select a base x,y coordinate to create a tile for The Grid. 
 * Offset it randomly every time it appears in The Grid.
 * Ever 200 frames the grid will "re-roll" to a different dimension.
 **/

import processing.video.*;

Movie mov;
PGraphics pg;
int numX = (int) random(3, 12);
int numY = (int) random(3, 12);
PImage[][] img;
int tileWidth, tileHeight;
int getX, getY;
int[][] offsetX;
int[][] offsetY;
int cropX, cropY;
int rndrng = 50;
int counter = 0;

void setup() {
    size(800, 800);

    // make sure your vid is equal or larger than graphic size,
    // otherwise black pixels will appear.
    pg = createGraphics(800, 800); 
    mov = new Movie(this, "j1.mp4");
    mov.loop();

    while (width % numY != 0) {
        numY++;
    }
    while (width % numX != 0) {
        numX++;
    }

    img = new PImage[numX][numY];
    offsetX = new int[numX][numY];
    offsetY = new int[numX][numY];

    cropX = (int) random(0, width);
    cropY = (int) random(0, height);

    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            img[i][j] = new PImage();
        }
    }

    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            offsetX[i][j] = (int) random(-rndrng, rndrng);
            offsetY[i][j] = (int) random(-rndrng, rndrng);
        }
    }
    shuffle();
}

void draw() {
    if (counter > 200) {
        shuffle(); 
        counter = 0;
    }
    background(0);
    pg.beginDraw();
    pg.image(mov, 0, 0);

    for (int x = 0; x < numX; x++) {
        for (int y = 0; y < numY; y++) {
            getX = cropX + offsetX[x][y];
            getY = cropY + offsetY[x][y];
            
            getX = constrain(getX, 0, pg.width-tileWidth);
            getY = constrain(getY, 0, pg.height-tileHeight);
            img[x][y] = pg.get(getX, getY, tileWidth, tileHeight);
            image(img[x][y], x*tileWidth, y*tileHeight);
        }
    }
    pg.endDraw();
    counter++;
}

void shuffle() {
    numX = (int) random(4, 12);
    numY = (int) random(4, 12);
    while (width % numY != 0) {
        numY++;
    }
    while (width % numX != 0) {
        numX++;
    }

    tileWidth = width/numX;
    tileHeight = height/numY;
    img = new PImage[numX][numY];
    offsetX = new int[numX][numY];
    offsetY = new int[numX][numY];
    cropX = (int) random(0, width);
    cropY = (int) random(0, height);

    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            img[i][j] = new PImage();
        }
    }
    
    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) {
            offsetX[i][j] = (int) random(-rndrng, rndrng);
            offsetY[i][j] = (int) random(-rndrng, rndrng);
        }
    }
}

void mousePressed() {
    shuffle();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
    m.read();
}