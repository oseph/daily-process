/** 
* 016_PhotoGrid
* by Josh Holinaty / Jan.13.2016
* ---
* Select random x,y coordinate, and create a tile from a photo. 
* Offset it randomly every time it appears in The Grid.
* Inspired by example P_4_1_1_01 in the great book, Generative Design:
* http://www.generative-gestaltung.de/code
**/
import processing.video.*;

PImage img;
int tileCountX = (int) random(4, 10);
int tileCountY = (int) random(4, 10);
int tileCount;
PImage[] segs;

int cropX = 0;
int cropY = 0;
int tileWidth, tileHeight;

void setup() {
    size(800, 800);
    tileCount = tileCountX*tileCountY;
    segs = new PImage[tileCount];
    img = loadImage("photo-path-here"); 
    shuffle();
}

void draw() {
    int i = 0;
    for (int gridY = 0; gridY < tileCountY; gridY++) {
        for (int gridX = 0; gridX < tileCountX; gridX++) {
            image(segs[i], gridX*tileWidth, gridY*tileHeight);
            i++;
        }
    }
}

void shuffle() {
    int x, y;
    tileCountX = (int) random(4, 16);
    tileCountY = (int) random(4, 20);
    tileCount = tileCountX * tileCountY;
    segs = new PImage[tileCount];
    
    for (int i = 0; i < tileCount; i++) {
        segs[i] = new PImage();
    }
    
    tileWidth = width/tileCountX;
    tileHeight = height/tileCountY;

    // find random tile
    cropX = (int) random(0, width);
    cropY = (int) random(0, height);
    int i = 0;
    
    for (int gridY = 0; gridY < tileCountY; gridY++) {
        for (int gridX = 0; gridX < tileCountX; gridX++) {
            int offX = (int)(random(-tileWidth/2, tileWidth/2));
            int offY = (int)(random(-tileHeight/2, tileHeight/2));
            x = cropX + offX;
            y = cropY + offY;
            x = constrain(x, 0, width-tileWidth);
            y = constrain(y, 0, height-tileHeight);
            segs[i++] = img.get(x, y, tileWidth, tileHeight);
        }
    }
}

void mouseReleased() {
    shuffle();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}