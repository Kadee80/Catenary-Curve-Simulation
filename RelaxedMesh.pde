import processing.video.*;

// This sketch is adapted from Daniel Shiffman's 
// Nature of Code Example SoftBodySquareAdapted
// Katie Adee, 2012

import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;
import toxi.math.*;

VerletPhysics2D physics;
int modX = 5;
int modY = 5;
PFont f;

Blanket b;
Boolean IsBlanketClicked;
Boolean IsParticleLocked;
Particle SelectedParticle;
void setup() {
  size(800, 800);
  smooth();
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.2)));
  b = new Blanket();
  IsBlanketClicked = false;
  f = createFont("Georgia", 10, true);
}

void draw() {

  background(255);

  physics.update();

  b.display();

  // Instructions
  fill(100);
  noStroke();
  rect(0,0,width,50);
  fill(255);
  textFont(f);
  text("'UP' to shorten vertical chains \n'DOWN' to lengthen vertical chains", 10, 20);
  text("'LEFT' to shorten horizontal chain \n'RIGHT' to lengthen horizontal chain", 200, 20);

  text("Click and drag red particles to move \nRight click red particles to unlock", 400, 20);
  text("Click and drag red particle again to re-lock\n'Spacebar' to refresh drawing", 600, 20);
  saveFrame("test-######.png");
}

void mousePressed() {
  //Check to see if first click is with Blanket
  ArrayList<Particle> Particles = b.particles;
  //println(Particles);
  for (int i = 0; i < Particles.size(); i++) {
    Particle particle = (Particle) Particles.get(i);
    if (particle.contains(mouseX, mouseY) && particle.IsMoveable)
    {
      println("clicked on c blanket");
      IsBlanketClicked = true;
      SelectedParticle = particle;
      IsParticleLocked = true;
      if (mouseButton == RIGHT) {

        IsParticleLocked=!IsParticleLocked;
        if (IsParticleLocked) {
          SelectedParticle.lock();
        } 
        else {
          SelectedParticle.unlock();
        }
      }
      IsParticleLocked = true;
    }
  }
}
void mouseDragged() {

  if (IsBlanketClicked)
  {
    //Mouve Blanker
    println("about to move blanket to " + mouseX + "," + mouseY);
    SelectedParticle.lock();
    SelectedParticle.x = mouseX;
    SelectedParticle.y = mouseY;
    SelectedParticle.update();
  }
  else {
    //Do nothing
    println("Not moving blanket");
  }
}
void mouseReleased() {

  if (IsBlanketClicked)
  {
    //move blanket
    println("about to move blanket to " + mouseX + "," + mouseY);
    SelectedParticle.x = mouseX;
    SelectedParticle.y = mouseY;
    SelectedParticle.update();
    IsBlanketClicked = false;
  }
  else {
    //Do nothing
    //println("Not moving blanket");
  }
}

void keyPressed() {
  if (key == ' ') {
    setup();
  }

  if (key == CODED &&  keyCode == RIGHT) {
    if (modX <12 ) {
      modX = modX+1;
      setup();
    }
  }

  if (key == CODED&&keyCode == LEFT) {
    if (modX >1 ) {
      modX = modX-1;
      setup();
    }
  }

  if (key == CODED &&  keyCode == DOWN) {
    if (modY <12 ) {
      modY = modY+1;
      setup();
    }
  }
  if (key == CODED&&keyCode == UP) {
    if (modY >1 ) {
      modY = modY-1;
      setup();
    }
  }
} 

