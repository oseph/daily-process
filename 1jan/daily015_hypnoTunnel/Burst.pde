class Burst {

    float s, e;
    private float num;
    float sx, sy, ex, ey;
    float length;
    float speed;
    float initE;
    color colr;
    float w;
    float rot;

    public Burst(float s) {
        this.num = (int)random(15, 60);
        this.s = s;
        this.length = random(50, 450);
        this.speed = (int)random(3, 6);
        this.colr = (random(100) > 70) ? color(0) : (random(100) > 50) ? color(255) : color(125); // B&W
        //this.colr = color( random(0,255), random(0,255),  random(0,255)); // COLOUR
        this.w = random(1, 20);
        rot = 0.5f;
        e = 0;
        this.initE = e;
    }

    void update() {
        if (s > width*0.8) {
            w = random(1, 20);
            colr = (random(100) > 70) ? color(0) : (random(100) > 50) ? color(255) : color(125); // B&W
            // colr = color( random(0,255), random(0,255),  random(0,255)); // COLOUR
            num = (int)random(15, 60);
            length = random(50, 450);
            s = 0;
            e = 0;
        }

        if (e < length) {
            e += speed;
            s = 0;
        } else {
            s += speed;
            e += speed;
        }
        rot+= 0.2f;
    }

    void display() {
        stroke(colr);
        strokeWeight(w);
        rotate(radians(rot));
        for (int i = 0; i < num; i++) {
            sx = sin(radians(i * (360 / num))) * s;
            sy = cos(radians(i * (360 / num))) * s;
            ex = sin(radians(i * (360 / num))) * e;
            ey = cos(radians(i * (360 / num))) * e;
            line(sx, sy, ex, ey);
        }
    }
}