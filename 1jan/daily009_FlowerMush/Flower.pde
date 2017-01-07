class Flower {
    PGraphics pg;
    float x;
    float y;
    float sqWidth;
    float sqHeight;
    float cornerRadius;
    float speed;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float n;
    float rot;
    float rotSpeed;
    float theta;
    float opacity;
    float rotFlip;
    float num;
    float size;
    float numSpeed;
    float life;


    Flower(float x, float y, float numSpeed, float size) {  
        this.x = cos(theta) + x;
        this.y = sin(theta) + y;
        this.numSpeed = numSpeed;
        this.size = size;
        num = numSpeed;
        pg = createGraphics((int)size, (int)size, P2D);
        r = random(0,255);
        g = random(0,255);
        b = random(0,255);
        c = (random(1) < 0.5 ) ? color(0) : color(255);
        sqWidth = random(size*0.2, size*0.4);
        sqHeight = sqWidth*.4;
        rx = random(0, 5000);
        rot = random(0, 180);
        rotSpeed = random(1, 6);
        theta = random(100);
        opacity = random(150, 255);
        speed = 0.01;
        rotFlip = (random(1) < 0.5 ) ? 1 : -1;
        cornerRadius = random(0, 50);
        life = random(50,150);
        
    }

    void updater() {
        if (life > 0) {
            if (sqWidth < 5 || sqHeight < 5 ) {
                opacity = 0;
                life--;
            } else {
                n = noise(rx);
                rx += 0.05;
                rot+=rotSpeed+n;
                theta -= speed;
                sqWidth -= numSpeed/num;
                sqHeight -= numSpeed/num;
                life--;
            }
        } else {
         opacity = 0;
         return;   
        }
    }

    void display() {
        pg.noSmooth();
        pg.beginDraw();
        pg.noStroke();
        pg.background(0,0);
        pg.rectMode(CORNER);
        pg.fill(c, opacity);
        pg.pushMatrix();
        pg.translate(size/2, size/2);
        pg.rotate(radians(rot*rotFlip));
        pg.rect(0, 0, sqWidth, sqHeight, cornerRadius);
        pg.popMatrix();
        pg.endDraw();
        image(pg, x, y);
    }
}