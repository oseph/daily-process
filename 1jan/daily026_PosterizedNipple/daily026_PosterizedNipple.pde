/**
 * 026_CubeCrystal
 * by Josh Holinaty / Jan.22.2017
 * ---
 * Overlapping cubes with darken blend mode for fun effect.
 **/

boolean saveFrames = false;
color c;
int num = (int)random(6, 10);
float rot;
//int rot;
Cloud[] clouds = new Cloud[1];

void setup() {
    size(800, 800, P3D);
    c = color(random(220, 240), random(200, 255), random(200, 255));
    background(c);
    for (int i = 0; i < clouds.length; i++) {
        clouds[i] = new Cloud(num);
    }
    colorMode(HSB);
    rot = random(360);
    
}

void draw() {
    //background(50);
    for (Cloud c : clouds) {
        c.display();
    }
    
    filter(POSTERIZE,5);
    if (saveFrames) {
        saveFrame("imgs5/img-####.tga");
    }
}

void mousePressed() {
    num = (int)random(6, 10);
    for (int i = 0; i < clouds.length; i++) {
        clouds[i] = new Cloud(num);
    }
}

class Cloud {
    PShape c;
    int[] x;
    int[] y;
    int[] z;
    int[] weight;
    color[] clr;
    int num;

    Cloud(int num) {
        this.num = num;
        x = new int[num];
        y = new int[num];
        z = new int[num];
        weight = new int[num];
        clr = new int[num];
        for (int i = 0; i < num; i++) {
            x[i] = (int)random(0, 250);
            y[i] = (int)random(0, 250);
            z[i] = (int)random(0, 250);
            weight[i] = (int)random(10, 100);
            clr[i] = color(random(256),random(256),random(256));
        }
        c = createShape();
        c.beginShape();
        c.noFill();
        for (int i = 0; i < num; i++) {
            c.stroke(clr[i]);
            c.strokeWeight(weight[i]);
            c.vertex(x[i], y[i], z[i]);
        }
        c.endShape();
    }

    void display() {
        translate(width/2, width/2);  
        rotate(radians(rot));
        translate(-c.width/2, -c.height/2);
        shape(c);
        for (int i = 0; i < c.getVertexCount(); i++) {
            PVector v = c.getVertex(i);
            v.x += random(-2, 2);
            v.y += random(-2, 2);
            v.z += random(-2, 2);
            c.setVertex(i, v.x, v.y, v.z);
        }
        rot++;
    }
}