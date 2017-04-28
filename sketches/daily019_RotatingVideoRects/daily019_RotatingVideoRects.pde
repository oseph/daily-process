/**
 * 019_VideoRectss
 * by Josh Holinaty / Dec.16.2016
 * ---
 * Appropriating this early sketch to now pull from a video.
 * With some perlin kisses ^ * ^
 **/
import processing.video.*;

Movie mov;
PGraphics pg;
int num = 9; // number of rectangles
boolean saveFrames = true; // save frames for movie making fun
VideoRects[] rotaties = new VideoRects[num];
boolean filter = false;
int bg = (int) random(255);

void setup() {
    size(700, 700);
    pg = createGraphics(800, 800);
    mov = new Movie(this, "j1.mp4");
    mov.loop();
    background(bg);
    smooth();
    noStroke();
    makeRects();
}

void draw() {
    pg.beginDraw();
    pg.image(mov, 0, 0);
    for (int i = 0; i < rotaties.length; i++) {
        rotaties[i].display();
        rotaties[i].grow();
    }
    pg.endDraw();
    if (saveFrames) {
        saveFrame("imgs/img_#####.png");
    }
}

void mousePressed() {
    bg = (int) random(255);
    background(bg);
    makeRects();
    filter = !filter;
}

void makeRects() {
    for (int i = 0; i < rotaties.length; i++) {
        rotaties[i] = new VideoRects(width/2, height/2);
    }
}

class VideoRects {
    PImage img;
    float x;
    float y;
    float rectWidth;
    float rectHeight;
    color c;
    float iter;
    float rx;
    int getX, getY;
    float rot;
    float n;
    float rotFlip;
    int lifeSpan;
    boolean dead = false;
    int rotSpeed;

    VideoRects(float x, float y) {
        this.x = x;
        this.y = y;
        iter = 0.03;
        c = color(255, 255, 255, random(190, 255));
        rectWidth = (int) random(5, 100);
        rectHeight = random(height*0.4, height*.8);
        img = new PImage();
        rx = random(0, 5000);
        getX = (int) random(800);
        getY = (int) random(800);
        getX = constrain(getX, 0, 800-(int)rectWidth);
        getY = constrain(getX, 0, 800-(int)rectHeight);
        rot = random(360);
        rotSpeed = (int) random(1, 4);
        rotFlip = (random(100) > 50) ? 1 : -1;
        lifeSpan = (int) random(25, 100);
    }

    void grow() {
        //x++;
        if (lifeSpan > 0) {
            n = noise(rx);
            rx += iter;
            if (n > 0.5) {
                x = x+n;
                y = y-n;
            } else {
                x = x-n;
                y = y+n;
            }
            rot+=rotSpeed;
            lifeSpan--;
        } else {
            dead = true;
        }
    }

    void display() {
        tint(c);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot*rotFlip));
        translate(-rectWidth/2, -rectHeight/2);
        if (!dead) {
            img = pg.get(getX, getY, (int)rectWidth, (int)rectHeight);
            if (filter) {
                img.filter(THRESHOLD, 0.4);
            }
            image(img, 0, 0, rectWidth, rectHeight);
        }
        popMatrix();
    }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
    m.read();
}
