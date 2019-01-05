class Particle{
  
  PVector pos;
  
  Particle(int x, int y){
    pos = new PVector(x,y);
  }

  int x(){
    return int(pos.x);
  }

  int y(){
    return int(pos.y);
  }

}

final int BCK_COLOR = 0xEEEEEE;
final int PRT_COLOR = 0x000000;
final int grav_const = 1;
final float drift_factor = 0.2;
ArrayList<Particle> particles;

void setup(){

  particles = new ArrayList();
  background(BCK_COLOR);
  stroke(PRT_COLOR);
  fullScreen();
  noSmooth();
  
}

void draw(){
  
  background(BCK_COLOR);
  stroke(PRT_COLOR);
  
  fill(0x0);
  rect(0, height/2, width-1, height/2);
  
  if(mousePressed){
  
    createNewParticle(mouseX, mouseY);
  
  }
  
  loadPixels();
  
  for(Particle p : particles){
    point(p.x(), p.y());
  }
  
  step();
  deleteDeadParticles();

}

void point(PVector pos){
  
  point(pos.x, pos.y);

}

void createNewParticle(int x, int y){

  particles.add(new Particle(x, y));
  println("Particle created");

}

void mousePressed(){
  createNewParticle(mouseX, mouseY);
}

void mouseDragged(){
  createNewParticle(mouseX, mouseY);
}

void keyPressed(){
  redraw();
}

void deleteDeadParticles(){
  
  // Iterate backwards to avoid errors
  for(int i = particles.size()-1; i >= 0; i--){
  
    if(particles.get(i).y() >= height){
      
      particles.remove(i);
      println("Particle deleted");
      
    }
    
  }

}

void step(){
  
  for(Particle p : particles){
    
    int colorBelow = get(p.x(), p.y()+1)&0xFFFFFF;
    if(colorBelow == PRT_COLOR){
    
      continue;
    
    }
    
    // Move one down if nothing is blocking
    p.pos.y += grav_const;
  
    // Do some horizontal jiggling
    int drift = 0;
    if(random(0,1) <= drift_factor)
      drift = int(random(-2,2));
    p.pos.x += drift;

  }

}
