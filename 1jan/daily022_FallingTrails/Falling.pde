class Falling {
    ArrayList<Shape> trail; 
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
        trail = new ArrayList<Shape>();
        this.x = x;
        this.y = y;
        iter = 0.05;
        w = random(10,300);
        c = color(random(255), random(255), random(255));
        speed = (int)random(5, 8);
        rx = random(0, 5000);
        //life = (int)random(50, 300);
        this.num = num;
    }

    void display() {
        update();
        if (trail.size() < num) {
            trail.add(new Shape(x, y, w, w, c));
        }      
        if (trail.size() == num && trail.size() > 0) {
            trail.remove(0);
        }

        for (int i = 0; i < trail.size(); i++) {
            Shape r = trail.get(i);
            r.display();
        }
    }

    void update() {
        n = noise(rx);
        rx += iter;
        y+=speed;

        if (n > 0.5) {
            x+=n*3;
        } else {
            x-=n*3;
        }
    }
}