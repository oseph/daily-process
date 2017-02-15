/**
 * 030_PixelSorterA
 * by Josh Holinaty / Feb.10.2017
 * ---
 * A few pixel sorting functions:
 * Sort rows, columns, find average colour...
 **/
 
PImage img1;

void setup() {
    img1 = loadImage("--your_Image--");
    size(600, 600);
    image(img1, 0, 0);
}

void draw() {
    sortChunksX(1);
    sortChunksY(1);
}

void mousePressed() {
    PImage tmp = get();
    translate(width/2, height/2);
    rotate(HALF_PI);
    translate(-tmp.width/2, -tmp.height/2);
    image(tmp, 0, 0);
}

PImage makeNoise() {
    PImage img = createImage(width, height, RGB);
    img.loadPixels();
    float r = random(5000);
    float xoff = r;
    for (int x = 0; x < width; x++) {
        xoff += 0.03;
        float yoff = r;
        for (int y = 0; y < height; y++) {
            yoff += 0.03;
            int loc = x + y*width;
            float col = noise(xoff, yoff)*255;
            img.pixels[loc] = color(col);
        }
    }
    img.updatePixels();
    return img;
}

// Sort each pixel row from darkest to lighest
void sortDarkToLight() {
    loadPixels();
    for (int x = 1; x < width; x++) {
        for (int y = 0; y < height; y++) {
            float b1 = brightness(pixels[x-1+y*width]);
            float b2 = brightness(pixels[x+y*width]);
            if (b1 > b2) {
                int tmp = pixels[x-1+y*width];
                pixels[x-1+y*width] = pixels[x+y*width];
                pixels[x+y*width] = tmp;
            }
        }
    }
    updatePixels();
}


// Sort pixels rows in grid.
void sortChunksX(int num) {
    loadPixels();
    int grid = width/num;
    for (int cx = 0; cx < num; cx++) {
        for (int cy = 0; cy < num; cy++) {
            for (int x = 1; x < grid; x++) {
                for (int y = 0; y < grid; y++) {
                    int gx = x+(cx*grid);
                    int gy = y+(cy*grid);
                    int loc = gx + gy * width; 
                    float b1 = brightness(pixels[loc-1]);
                    float b2 = brightness(pixels[loc]);
                    if (cy%2==0) {
                        if (b1 < b2) {        
                            int tmp = pixels[loc-1];
                            pixels[loc-1] = pixels[loc];
                            pixels[loc] = tmp;
                        }
                    } else {
                        if (b1 > b2) {        
                            int tmp = pixels[loc-1];
                            pixels[loc-1] = pixels[loc];
                            pixels[loc] = tmp;
                        }
                    }
                }
            }
        }
    }
    updatePixels();
}

// sort pixel columns in grid
void sortChunksY(int num) {
    loadPixels();
    int grid = width/num;
    for (int cx = 0; cx < num; cx++) {
        for (int cy = 0; cy < num; cy++) {
            for (int x = 0; x < grid; x++) {
                for (int y = 1; y < grid; y++) {
                    int gx = x+(cx*grid);
                    int gy = y+(cy*grid);
                    int loc1 = gx + (gy * width); 
                    int loc2 = gx + ((gy-1) * width); 
                    float b1 = brightness(pixels[loc1]);
                    float b2 = brightness(pixels[loc2]);
                    if (cy%2==0) {
                        if (b1 < b2) {        
                            int tmp = pixels[loc1];
                            pixels[loc1] = pixels[loc2];
                            pixels[loc2] = tmp;
                        }
                    } else {
                        if (b1 > b2) {        
                            int tmp = pixels[loc1];
                            pixels[loc1] = pixels[loc2];
                            pixels[loc2] = tmp;
                        }
                    }
                }
            }
        }
    }
    updatePixels();
}

// Add up all the colours in a row and
// find the average colour.

void findAverageRowColor() {
    loadPixels();
    for (int rows = 0; rows < height; rows++) {
        int rSum = 0;
        int gSum = 0;
        int bSum = 0;  
        for (int x = 0; x < width; x++) {   
            rSum += (pixels[x+rows*width] >> 16) & 0xFF;
            gSum += (pixels[x+rows*width] >> 8) & 0xFF;  
            bSum += pixels[x+rows*width] & 0xFF;
        }
        rSum = rSum / width;
        gSum = gSum / width;
        bSum = bSum / width;
        for (int x = 0; x < width; x++) {   
            pixels[x+rows*width] = color(rSum, gSum, bSum);
        }
    }
    updatePixels();
}