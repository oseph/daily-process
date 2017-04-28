class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float mass;
  float maxSpeed;
  float maxForce;
  color c1, c2;

  Vehicle(PVector l, float ms, float mf, float size) {
    location = l.copy();
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    r = size;
    maxSpeed = ms;
    maxForce = mf;
    c1 = color(random(255), random(50,235), random(235));
    float r = red(c1);
    float g = green(c1);
    c2 = color(g, r, random(50,255));
  }
  
  void run() {
    update();
    display();
    checkEdges();
  }
  
  void follow(FlowField flow) {
    PVector desired = flow.lookUp(location);
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void checkEdges() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.div(0.05);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  // follow a specific target
  void arrive(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    float d = desired.mag();
    // Normalize desired and scale with arbitrary damping within 100 pixels
    desired.normalize();
    if (d < 100) {
      float m = map(d,0,100,0,maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(maxSpeed);
    }
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxForce);  // Limit to maximum steering force
    applyForce(steer);
  }
  
   void display() {
    float theta = velocity.heading() + PI/2;
    fill(c1);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipse(0,0, r, r);
    
    //optional trailer
    //strokeWeight(r*0.05);
    //stroke(c2);
    //line(0,r/2,0,0);
    
    noStroke();
    popMatrix();
  }
}  