class Falling {
    PGraphics pg;
    Queue trail; 
    float x;
    float y;
    float speed;
    float speedY;
    float speedX;
    float iterate;
    float rx1, rx2;
    float noise1, noise2;
    int num;
    color c; 
    float w;
    float h;
    boolean dead = false;
    int r, g, b;
    int life;
    int lifeTime;

    Falling(float x, float y, int num, float w) {
        trail = new LinkedList();
        pg = createGraphics(width, height, P2D);
        this.x = x;
        this.y = y;
        iterate = 0.08;
        this.w = w;
        r = (int) random(256);
        g = (int) random(200, 256);
        b = (int) random(200, 256);
        c = color(r, g, b);
        speed = random(2);
        speedX = speed * (random(100) > 50 ? 1 : -1); 
        speedY = speed * (random(100) > 50 ? 1 : -1);
        rx1 = random(0, 5000);
        rx2 = random(4000, 8000);
        this.num = num;
        lifeTime = (int)random(20, 200);
        life = 0;
    }

    void display() {
        update();
        
        if (life < lifeTime) {
            if (trail.size() < num) {         
                trail.add(new Shape(pg, x, y, w, w, c));
            }
        } 

        if (trail.size() == num && trail.size() > 0) {
            trail.poll();
        }

        for (Iterator<Shape> it = trail.iterator(); it.hasNext(); ) {
            Shape r = it.next();
            r.display();
        }
        life++;
    }


    void update() {
        rx1 += iterate;
        rx2 += iterate;
        noise1 = noise(rx1); 
        noise2 = noise(rx2);

        if (noise1 > 0.5) {
            y+=speedY+(noise1*speed);
            x+=speedX+(noise2*speed);
        } else {
            y+=speedY-(noise1*speed);
            x+=speedX-(noise2*speed);
        }

        if (y > height) { 
            y = height;
            speedY *= -1;
        }
        if (y < 0) { 
            y = 0;
            speedY *= -1;
        }
        if (x > width) { 
            x = width;
            speedX *= -1;
        }
        if (x < 0) { 
            x = 0;
            speedX *= -1;
        }
    }
}