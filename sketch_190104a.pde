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
  //particles.add(new Particle(0,0));
  background(BCK_COLOR);
  stroke(PRT_COLOR);
  //size(400, 400);
  //noLoop();
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

  //loadPixels();
  
  //int topColor = get(width/2, int(height*.25))&0xFFFFFF;
  //int bottomColor = get(width/2, int(height*.75))&0xFFFFFF;
  
  //println(int(topColor), hex(topColor));
  //println(int(bottomColor), hex(bottomColor));
  
  //println(int(BCK_COLOR), hex(BCK_COLOR));
  //println(int(PRT_COLOR), hex(PRT_COLOR));

}

void point(PVector pos){
  
  point(pos.x, pos.y);

}

void createNewParticle(int x, int y){

  particles.add(new Particle(x, y));
  println("Particle created");

}

void mousePressed(){

  //redraw();
  
  createNewParticle(mouseX, mouseY);
  
  //int mouseColor = get(mouseX, mouseY)&0xFFFFFF;
  //println("x:"+mouseX, "y:"+mouseY, int(mouseColor), hex(mouseColor));
  
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
    
    //println("x:"+p.x(), "y:"+p.y());
    //println(hex(colorBelow));
    
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
