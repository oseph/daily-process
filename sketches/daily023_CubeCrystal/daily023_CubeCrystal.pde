/**
 * 023_CubeCrystal
 * by Josh Holinaty / Jan.22.2017
 * ---
 * Overlapping cubes with darken blend mode for fun effect.
 **/

boolean saveFrames;
PGraphics cubeA;
PGraphics cubeB;
PGraphics cubeC;
PGraphics cubeD;
color c;

void setup() {
    size(800, 800, P3D);
    c = color(random(220, 240), random(200, 255), random(200, 255));
    background(c);
    cubeA = createGraphics(width, height, P3D);
    cubeB = createGraphics(width, height, P3D);
    cubeC = createGraphics(width, height, P3D);
    cubeD = createGraphics(width, height, P3D);
    saveFrames = false;
    blendMode(DARKEST);
}

void draw() {
    background(c);
    
    drawCube(cubeA, 75, 98, 0, 1);
    drawCube(cubeB, 70, 40, 55, -1);
    drawCube(cubeC, 50, 90, 140, 1);
    drawCube(cubeD, 90, 90, 100, -1);

    image(cubeA, 0, 0);
    image(cubeB, 0, 0);
    image(cubeC, 0, 0);
    image(cubeD, 0, 0);
    
    if (saveFrames) {
        saveFrame("imgs5/img-####.tga");
    }
}

void drawCube(PGraphics cube, float xd, float yd, float h, float r) {
    cube.beginDraw();
    cube.colorMode(HSB);
    cube.clear();
    cube.lights();
    cube.ambientLight(h, 255, 168);
    cube.noStroke();
    cube.translate(cube.width/2, cube.height/2);
    cube.rotateX(frameCount/xd * r);
    cube.rotateY(frameCount/yd * r);
    cube.box(width*.35);
    cube.endDraw();
}