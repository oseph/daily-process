/**
 * 015-HypnoTunnel
 * by Josh Holinaty / Jan.12.2016
 * ---
 * The endless vortex. Feel free to add colour.
 **/

boolean saveFrames = false;
int num = 5;
Burst[] bursts = new Burst[num];

void setup() {
    size(800, 800);
    smooth();
    for (int i = 0; i < bursts.length; i++) {
        bursts[i] = new Burst(0);
    }
}

void draw() {

    translate(width/2, height/2);

    for (Burst b : bursts) {
        b.update();
        b.display();
    }
    
    if (saveFrames) {
        saveFrame("imgs2/img-####.tga");
    }
}