/*
* 035_FlowFieldFun  
* by Josh Holinaty / Mar.1.2017
* ---
* Some flow fields and auto walkers. 
* This is based off the 'Autonomous Agents' chapter
* from Daniel Shiffman's 'The Nature of Code'.
*/

ArrayList<Vehicle> vehicles;
FlowField flow;
int flowRes = 52; // flow field is w and h of flowField (flowRes * flowRes)

void setup() {
  size(800, 800);
  noSmooth();
  vehicles = new ArrayList<Vehicle>();
  flow = new FlowField(int(width/flowRes));
  for (int i = 0; i < 120; i++) {
    vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(2, 5), random(0.1, 0.5), random(1, 1*i/2)));
  }
}

void draw() {
  for (Vehicle v : vehicles) {
    v.follow(flow);
    v.run();
  }
}

void mousePressed() {
  flow.init();
}