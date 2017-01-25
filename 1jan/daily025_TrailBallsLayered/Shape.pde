class Shape {

    PGraphics pg;
    color c;
    float w;
    float h;
    float x, y;

    Shape(PGraphics pg, float x, float y, float w, float h, color c ) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
        this.pg = pg;
        
    }

    void display() {
        pg.beginDraw(); 
        pg.noStroke();
        pg.fill(c);
        pg.ellipse(x, y, w, w);
        pg.endDraw();
        image(pg, 0, 0);
    }
}