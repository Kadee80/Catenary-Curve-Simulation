class Blanket {
  ArrayList<Particle> particles;
  ArrayList<Connection> springs;

  float len = 5;
  float strength = 1.5;
  int modulusX = modX;
  int modulusY = modY;
  int w = (modulusX*10)+1;
  int h = (modulusY*10)+1;

  Blanket() {
    particles = new ArrayList<Particle>();
    springs = new ArrayList<Connection>();


    int radius;
    // Play here to change the "structure"
    for (int y=0; y< h; y++) {
      for (int x=0; x < w; x++) {
        println("X: " + x + " Y: " + y);
        Particle p;
        if (  (x==0 && y==0) //Left Top Corner
        || (x==w-1 && y==0) //Right Top corner
        || (x==0 && y==h-1) //Left Bottom corner
        || (x==w-1 && y==h-1)// Right Bottom corner
        || (x==((w-1)/2) && y==((h-1)/2)) //Center
        || (x==0 && y==((h-1)/2)) //Left middle
        || (x==w-1 && y==((h-1)/2)) //Right middle
        || (x==((w-1)/2) && y==0) //Top middle
        || (x==((w-1)/2) && y==h-1)) //bottom middle
        {
          //Moveable Balls
          p = new Particle(new Vec2D(width/2+x*len-w*len/2, 100+ y*len), 8, true, x, y);
          BuildConnections(p, x, y);
          p.lock();
        }
        else if ((x > 0&& y%modulusY ==0) || (y > 0 && x%modulusX==0))
        {
          //Regular Balls
          p = new Particle(new Vec2D(width/2+x*len-w*len/2, 100+ y*len), 2, false, x, y);
          BuildConnections(p, x, y);
        }
        else 
        {
          //Invisible Balls
          p = new Particle(new Vec2D(width/2+x*len-w*len/2, 100+ y*len), 0, false, x, y);
        }
        physics.addParticle(p);
        particles.add(p);
      }
    }
  }
  void BuildConnections(Particle p, int x, int y) {
    //building Left Connections
    if (x > 0 && y%modulusY==0) {
      Particle prevleftparticle = GetParticleByCoordinate(x-1, y);
      Connection horizontalconnection = new Connection(p, prevleftparticle, len, strength);
      physics.addSpring(horizontalconnection);
      springs.add(horizontalconnection);
    }
    //Vertical Connections
    if (y > 0 && x%modulusX==0) {
      Particle previousabove = GetParticleByCoordinate(x, y-1);
      Connection verticalconnection=new Connection(p, previousabove, len, strength);
      physics.addSpring(verticalconnection);
      springs.add(verticalconnection);
    }
  }
  //Get a particle based on coordinates
  Particle GetParticleByCoordinate(int xcord, int ycord)
  {
    Particle ParticleToReturn = new Particle(new Vec2D(0, 0), 0, false, 0, 0);
    for (int i = 0; i < particles.size(); i++) {
      Particle particle = (Particle) particles.get(i);
      if (particle.XCord == xcord && particle.YCord == ycord)
        ParticleToReturn = particle;
    }
    return ParticleToReturn;
  }
  void display() {
    for (Connection c : springs) {
      c.display();
    }

    for (Particle p : particles) {
      p.display();
    }
  }
}

