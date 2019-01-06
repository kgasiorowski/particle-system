final color EMPTY_COLOR = color(0);
final color PRT_COLOR = color(255, 234, 130);
ArrayList<Particle> particles;

void setup(){

  particles = new ArrayList();
  background(EMPTY_COLOR);
  stroke(PRT_COLOR);
  //fullScreen();
  size(800,600);
  noSmooth();
  
}

void draw(){
  
  loadPixels();
  background(EMPTY_COLOR);
  
  color rectcolor = color(128,128,128);
  stroke(rectcolor);
  fill(rectcolor);
  rect(0, height*.95, width-1, height-1);
  
  if(mousePressed)
    createNewParticle(mouseX, mouseY);
  
  deleteDeadParticles();
  
  for(Particle p : particles){
    p.step();
    stroke(p.prt_color);
    point(p.x(), p.y());
  }
  
  
}

void point(PVector pos){
  point(pos.x, pos.y);
}

void createNewParticle(int x, int y){

  particles.add(new Particle(x, y, PRT_COLOR));

}

void deleteDeadParticles(){
  
  // Iterate backwards to avoid errors
  for(int i = particles.size()-1; i >= 0; i--){
  
    if(particles.get(i).y() >= height || particles.get(i).x() >= width){
      
      particles.remove(i);
      
    }
    
  }

}

void mousePressed(){
  createNewParticle(mouseX, mouseY);
}

void mouseDragged(){
  createNewParticle(mouseX, mouseY);
}

void keyPressed(){
  //stick_factor = abs(stick_factor - 1);
}
