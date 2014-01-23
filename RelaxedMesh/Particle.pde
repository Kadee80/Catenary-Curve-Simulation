class Particle extends VerletParticle2D {

  int Radius;
  boolean IsMoveable;
  int XCord;
  int YCord;

  Particle(Vec2D loc, int radius, boolean ismoveable, int xcord, int ycord) {
    super(loc);
    Radius = radius;
    IsMoveable = ismoveable;
    YCord = ycord;
    XCord = xcord;
  }

  void display() {
    if (IsMoveable == true) {
      fill(2550, 0, 0, 127);
    }
    else {
      fill(0, 50);
    }
    strokeWeight(.5);
    stroke(0);
    ellipse(x, y, Radius, Radius);
  }
  // check to see if mouse is clicked on a particle
  boolean contains(int x, int y) {
    float d = dist(x, y, this.x, this.y);
    if (d <= Radius) {
      return true;
    }
    else 
      return false;
  }
}

