/** 
 * 011_ColourStrips
 * by Josh Holinaty / Jan.08.2016
 * ---
 * Box of Crayons Simulator 9000.
 * Click to restart.
 **/

boolean saveFrames = false;
float ang, inc, x, y, strW, count; 
int rotoCount, mainCount, rows;
color str;
boolean flip;

void setup() {
    size(800, 800);
    background(random(255), random(255), random(255));
    str = color(random(255), random(255), random(255));
    inc = 0;
    count = 20;
    rotoCount = 0;
    mainCount = 0;
    x = random(-3, 3);
    y = 0;
    strW = random(2, 6);
    rows = (int)random(5, 12); // amount of rows in final composition
}

void draw() {
    if (mainCount > rows) {
        if (saveFrames) {
            saveFrame("imgs/img-#####.png");
        }    
    } else {

        if (mainCount == 0) {
            y = 0;
        } else {
            y += random(-5, 5);
        }
        
        // if strips greater than width, bump y coord down, and move x in opposite direction.
        if (inc > width) {
            inc = 0;
            strW+=3;
            y+= height/rows;
            rotoCount++;
            flip = !flip;
        }

        if (rotoCount > 0) {
            rotoCount = 0;
            mainCount++;
        }

        if (flip) { 
            x -= count;
        } else {
            x += count;
        }
        
        inc += count; 
        translate(x, y);
        strokeWeight(strW);
        str = color(random(255), random(255), random(255));
        stroke(str);
        line(sin(radians(0)), cos(radians(0)), sin(radians(random(-5, 5)))*height, cos(radians(random(-5, 5)))*height);

        if (saveFrames) {
            saveFrame("imgs/img-#####.png");
        }
    }
}

void mousePressed() {
    flip = false;
    x = 0;
    y = 0;
    inc = 0;
    strW = random(1, 3);
    rotoCount = 0;
    mainCount = 0;
    background(random(255), random(255), random(255));
    rows = int(random(5, 15));
}