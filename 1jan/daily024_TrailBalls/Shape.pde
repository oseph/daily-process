class Shape {
    color c;
    float w;
    float h;
    float x, y;

    Shape(float x, float y, float w, float h, color c ) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
    }

    void display() {
        fill(c);
        ellipse(x, y, w, w);
    }
}