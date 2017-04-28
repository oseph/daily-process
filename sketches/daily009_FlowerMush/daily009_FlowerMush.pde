/**
 * 008_FlowerMush
 * by Josh Holinaty / Jan.06.2017
 * ---
 * Black and white roto mushes. Sort of like flowers? 
 */

boolean saveFrames = false; 
int resL = 1; // minimum grid dimension
int resH = 4; // resH-1 = max grid dimension
int gridRes = (int)random(resL, resH);
int num = 15; // number of rectangles per flower
FlowerFactory[][] flowers;
int count;
color c;

void setup() {
    size(800, 800, P2D);
    count = 0;
    makeFlowers();    
}

void mousePressed() {
    if (count > 500) {
        loop();
    } else {
        makeFlowers();
    }
}

void draw() {
    if (count > 500) {
        noLoop();
    } else {
        for (int i = 0; i < flowers.length; i++) {
            for (int j = 0; j < flowers[i].length; j++) {
                flowers[i][j].display();
            }
        }
        if (saveFrames) {
            saveFrame("imgs/img-#####.png");
        }
        count++;
    }
}

void makeFlowers(){
    c = (random(1) < 0.5 ) ? color(0) : (random(1) < 0.5 ) ? color(125) : color(255);
    background(c);
    gridRes = (int)random(resL, resH);
    flowers = new FlowerFactory[gridRes][gridRes];
    for (int i = 0; i < flowers.length; i++) {
        for (int j = 0; j < flowers[i].length; j++) {
            flowers[i][j] = new FlowerFactory(i*(width/gridRes), j*(height/gridRes), num, width/gridRes);
        }
    }
}

class FlowerFactory {

    Flower[] flower;
    float x;
    float y;
    int num;
    float size;
    float numSpeed;

    FlowerFactory(float x, float y, int num, float size) {
        this.x = x;
        this.y = y;
        this.num = num;
        this.size = size;
        flower = new Flower[num]; 
        numSpeed = 1;

        for (int i = 0; i < num; i++) {
            if (numSpeed > num) {
                numSpeed = num;
            } else {
                numSpeed += 0.5;
            }
            flower[i] = new Flower(x, y, numSpeed, size);
        }
    }

    void display() {
        for (int i = 0; i < num; i++) {
            flower[i].updater();
            flower[i].display();
        }
    }
}