class Falling {
    Queue trail; 
    float x;
    float y;
    float speed;
    float iter;
    float rx;
    float n;
    int num;
    color c; 
    float w;
    float h;

    Falling(float x, float y, int num) {
        trail = new LinkedList();
        this.x = x;
        this.y = y;
        iter = random(0.005, 0.03);
        w = random(10,60);
        c = color(random(255), random(255), random(255));
        speed = (int)random(5, 8);
        rx = random(0, 5000);
        this.num = num;
    }

    void display() {
        update();
        if (trail.size() < num) {
            trail.add(new Shape(x, y, w, w, c));
        }      
        if (trail.size() == num && trail.size() > 0) {
            trail.poll();
        }

        for (Iterator<Shape> it = trail.iterator(); it.hasNext();) {
            Shape r = it.next();
            r.display();
        }
    }

    void update() {
        rx += iter;
        n = noise(rx);      
        y+=speed;

        if (n > 0.5) {
            x+=n;
        } else {
            x-=n;
        }
    }
}