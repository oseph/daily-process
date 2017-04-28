/** 
 * 010_ColourTunnel
 * by Josh Holinaty / Jan.07.2016
 * ---
 * A quick sketch with morning coffee. A little bit sloppy.
 * Click to restart.
 **/

boolean saveFrames = false;
float ang, s, sx, sy, e, ex, ey, inc; 
int rotoCount, mainCount;
color str;
boolean flip;


void setup() {
    size(800, 800);
    str = color(random(255), random(255), random(255));
    inc = 0;
    ang = random(0, 360);
    s = 0;
    e = width;
    rotoCount = 0;
    mainCount = 0;
}

void draw() {
    if (mainCount > 7) {
        saveFrame("imgs/img-#####.png");
    } else {
        if (inc > 360) {
            rotoCount++;
            flip = !flip;
            inc = 0;
        }
        if (rotoCount > 0) {
            s+=50;
            rotoCount = 0;
            mainCount++;
        }
        if (flip) { 
            ang -= 10;
        } else {
            ang += 10;
        }
        inc += 10; 
        
        sx = sin(radians(ang))*s;
        sy = cos(radians(ang))*s;
        
        ex = sin(radians(ang))*e;
        ey = cos(radians(ang))*e;
        
        translate(width/2, height/2);
        strokeWeight(random(10, 70));
        str = color(random(255), random(255), random(255));
        stroke(str);
        line(sx, sy, ex, ey);
        
        if (saveFrames) {
            saveFrame("imgs/img-#####.png");
        }
    }
}

void mousePressed() {
    inc = 0;
    s = 0;
    ang = random(0, 360);
    rotoCount = 0;
    mainCount = 0;
    loop();
}