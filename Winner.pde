class Winner{
  Winner(){

  }
  
  void draw(String teamName){
    frameRate(60);
    if (winningCounter == 0){
      player.pause();
      
      File winnerSong = new File(sketchPath() + "/data/DefaultMusic/victory_song.mp3");
      if (!winnerSong.exists()) {
        error.setError("Victory song not found");
      } else {
        player = minim.loadFile(sketchPath() + "/data/DefaultMusic/victory_song.mp3", 2048);
        player.play();
      }
    }
    
    background(color(0,0,255));

    int r = (int) winningCounter % 512;
    int g = (int) ((winningCounter*2)+85) % 512;
    int b = (int) ((winningCounter*3)+190) % 512;
    
    r = r - 255;
    g = g - 255;
    b = b - 255;
    
    ps1.addParticle();
    ps1.run();
    ps2.addParticle();
    ps2.run();
    ps3.addParticle();
    ps3.run();
  
    textSize(map(winningCounter, 0, 10000, 72, 1000));
    fill(color(abs(r),abs(g),abs(b)));
    //textAlign(CENTER);
    text(teamName, width/2, height/2);
    
    winningCounter++;
  }
  
  float winningCounter = 0;

  
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 4, 4);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
