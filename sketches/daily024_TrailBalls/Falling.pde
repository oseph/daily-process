class Falling {
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

    Falling(float x, float y, int num, float w) {
        trail = new LinkedList();
        this.x = x;
        this.y = y;
        iterate = 0.08;
        this.w = w;
        r = (int) random(256);
        g = (int) random(200, 256);
        b = (int) random(200, 256);
        c = color(r, g, b);
        speed = (int)random(5);
        speedX = speed * (random(100) > 50 ? 1 : -1); // random direction
        speedY = speed * (random(100) > 50 ? 1 : -1); //
        rx1 = random(0, 5000);
        rx2 = random(4000, 8000);
        this.num = num;
        lifeTime = (int)random(50, 200);
    }

    void display() {
        update();
        if (trail.size() < num) {         
            trail.add(new Shape(x, y, w, w, c));
        }  
        if (trail.size() == num && trail.size() > 0) {
            trail.poll();
        }

        for (Iterator<Shape> it = trail.iterator(); it.hasNext(); ) {
            Shape r = it.next();
            r.display();
        }
    }

    void update() {
        rx1 += iterate;
        rx2 += iterate;
        noise1 = noise(rx1); 
        noise2 = noise(rx2);

        if (noise1 > 0.5) {
            y+=speedY;
            x+=speedX;
            y += noise1*2;
            x += noise2*2;
        } else {
            y+=speedY;
            x+=speedX;
            y -= noise1*2;
            x -= noise2*2;
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