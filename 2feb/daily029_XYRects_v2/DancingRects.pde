class DancingRects {
    float x;
    float y;
    float initY;
    float rectWidth;
    float speed;
    float xDir, yDir;
    color c;
    float r, g, b;
    float iter;
    float rx;
    float midwayLimit;
    float n;
    float rot;
    int CIRCLE;

    DancingRects(float x, float y) {
        this.x = x;
        this.y = y;
        initY = y;
        iter = 0.05;
        c = color(random(235), random(235), random(235), 128);
        r = random(255);
        g = random(255);
        b = random(255);
        rectWidth = (int)random(10, (width/3)*2);
        speed = random(2, 5);
        rx = random(0, 5000);
        midwayLimit = random (height*.25, height*.75);
        rot = random(0, 360);
        yDir = random(100) > 50 ? -1 : 1;
        xDir = random(100) > 50 ? -1 : 1;
        CIRCLE = (int)random(0, 3);
    }

    void updater() {
        n = noise(rx);
        rx += iter;
        rot += n;
    }

    void grow() {
        if (n > 0.5) {
            y += n+speed*yDir;
            x += n+speed*xDir;
        } else {
            y += speed*yDir;
            x += speed*xDir;
        }
    }

    void display() {
        fill(c);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot));
        translate(-rectWidth/2, -rectWidth/2);
        if (CIRCLE == 0) {
            ellipse(0, 0, rectWidth, rectWidth);
        } else if (CIRCLE == 1) {
            rect(0, 0, rectWidth, rectWidth);
        } else {
            triangle(0, -rectWidth, -rectWidth, rectWidth, rectWidth, rectWidth);
        }
        popMatrix();
    }
}