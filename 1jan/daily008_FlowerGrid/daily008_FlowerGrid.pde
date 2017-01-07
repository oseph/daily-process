/**
 * 008_FlowerGrid
 * 
 FittoniaFlowers by Josh Holinaty
 an abstract flower factory
 */

boolean saveFrames = false; 
int resL = 1; // minimum grid dimension
int resH = 4; // resH-1 = max grid dimension
int gridRes = (int)random(resL, resH);
int num = 20; // number of rectangles per flower
FlowerFactory[][] flowers = new FlowerFactory[gridRes][gridRes];
int count;
color c;

void setup() {
    size(800, 800, P2D);
    c = color(random(200, 255), random(150, 255), random(200, 255));
    background(c);
    count = 0;
    for (int i = 0; i < flowers.length; i++) {
        for (int j = 0; j < flowers[i].length; j++) {
            flowers[i][j] = new FlowerFactory(i*(width/gridRes), j*(height/gridRes), num, width/gridRes);
        }
    }
}

void mousePressed() {
    if (count > 500) {
        loop();
    } else {
        gridRes = (int)random(resL, resH);
        flowers = new FlowerFactory[gridRes][gridRes];
        c = color(random(200, 255), random(150, 255), random(200, 255));
        background(c);
        for (int i = 0; i < flowers.length; i++) {
            for (int j = 0; j < flowers[i].length; j++) {
                flowers[i][j] = new FlowerFactory(i*(width/gridRes), j*(height/gridRes), num, width/gridRes);
            }
        }
        count = 0;
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