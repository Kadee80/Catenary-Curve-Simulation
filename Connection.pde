class Connection extends VerletSpring2D {
  Connection(Particle p1, Particle p2, float len, float strength) {
    super(p1, p2, len, strength);
  }

  void display() {
    strokeWeight(1);
    stroke(0,100);
    line(a.x, a.y, b.x, b.y);
  }
}

